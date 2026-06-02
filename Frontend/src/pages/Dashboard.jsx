import { useEffect, useMemo } from 'react'
import { jwtDecode } from "jwt-decode";
import { useAuth } from '../auth/authContext'
import Header from '../components/Header'

function Dashboard() {
  const { user, setUserClaims } = useAuth()

  const token = user?.token

  const decodedClaims = useMemo(() => {
    if (!token) return null
    try {
      return jwtDecode(token)
    } catch (error) {
      // eslint-disable-next-line no-console
      console.error('Failed to decode JWT', error)
      return null
    }
  }, [token])

  useEffect(() => {
    if (!decodedClaims) return

    const userId = decodedClaims.nameid || decodedClaims.sub || decodedClaims.NameId || decodedClaims.NameID
    const storeId = decodedClaims.StoreId || decodedClaims.storeId
    const fullName = decodedClaims.name || decodedClaims.Name || decodedClaims.fullname

    if (userId || storeId || fullName) {
      setUserClaims({ userId, storeId, fullName })
    }
  }, [decodedClaims, setUserClaims])

  const profileName = decodedClaims?.name || decodedClaims?.Name || decodedClaims?.fullname || ''

  return (
    <div style={{ display: 'flex', flexDirection: 'column', minHeight: '100vh', background: '#f8fbff' }}>
      <Header profileName={profileName} />
      <main style={{ flex: 1, padding: '24px' }}>
        <div style={{ maxWidth: 960, margin: '0 auto' }}>
          <h1 style={{ margin: 0, fontSize: 'clamp(2rem, 2.5vw, 2.5rem)', color: '#0f172a' }}>
            Dashboard
          </h1>
          <p style={{ marginTop: 12, color: '#475569', lineHeight: 1.75 }}>
            Welcome to your dashboard. This area is protected and only visible after signing in.
          </p>
        </div>
      </main>
    </div>
  )
}

export default Dashboard
