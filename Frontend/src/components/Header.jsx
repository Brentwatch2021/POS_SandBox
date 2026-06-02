import './Header.css'

function Header({ profileName = 'Jane Doe' }) {
  return (
    <header className="app-header">
      <div className="brand-panel">
        <div className="brand-mark">LOGO</div>
        <div className="brand-name">MyApp</div>
      </div>
      <div className="profile-panel">
        <span className="profile-name">{profileName}</span>
        <span className="profile-avatar" aria-hidden="true">
          <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <circle cx="12" cy="8" r="3.5" fill="currentColor" />
            <path d="M5 20c0-3.866 3.582-7 8-7s8 3.134 8 7" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" />
          </svg>
        </span>
      </div>
    </header>
  )
}

export default Header
