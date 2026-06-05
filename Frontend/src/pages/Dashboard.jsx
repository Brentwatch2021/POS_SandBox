import { useEffect, useState } from 'react'
import { useAuth } from '../auth/authContext'
import Header from '../components/Header'
import DashboardCharts from '../components/charts/DashboardCharts'
import Sidebar from '../components/Sidebar'

function Dashboard() {
  const { user } = useAuth()
  const [stockData, setStockData] = useState(null)
  const [stockError, setStockError] = useState(null)

  const profileName = user?.fullName || ''

  useEffect(() => {
    const token = localStorage.getItem('token')
    if (!token) {
      setStockError('No authentication token found.')
      return
    }

    const fetchStock = async () => {
      try {
        const response = await fetch('https://localhost:7051/GetStock', {
          method: 'GET',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json',
          },
        })

        if (!response.ok) {
          const errorText = await response.text()
          throw new Error(`${response.status} ${response.statusText}: ${errorText}`)
        }

        const data = await response.json()
        setStockData(data)
      } catch (error) {
        // eslint-disable-next-line no-console
        console.error('Failed to fetch stock data', error)
        setStockError(error.message)
      }
    }

    fetchStock()
  }, [])

  return (
    <div style={{ display: 'flex', minHeight: '100vh', background: '#f8fbff' }}>
      <Sidebar />
      <div style={{ flex: 1, display: 'flex', flexDirection: 'column' }}>
        <Header profileName={profileName} />
        <main style={{ flex: 1, padding: '24px' }}>
          <div style={{ maxWidth: 960, margin: '0 auto' }}>
            <h1 style={{ margin: 0, fontSize: 'clamp(2rem, 2.5vw, 2.5rem)', color: '#0f172a' }}>
              Dashboard
            </h1>
            <p style={{ marginTop: 12, color: '#475569', lineHeight: 1.75 }}>
              Welcome to your dashboard. This area is protected and only visible after signing in.
            </p>
            <DashboardCharts />
          </div>
        </main>
      </div>
    </div>
  )
}

export default Dashboard
