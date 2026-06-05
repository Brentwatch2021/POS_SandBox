import React, { useState } from 'react'
import './Sidebar.css'

const Icon = ({ name }) => {
  switch (name) {
    case 'home':
      return (
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M3 11.5L12 4l9 7.5" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />
          <path d="M5 21V12h14v9" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
      )
    case 'sales':
      return (
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M3 12h3l3 8 4-16 4 8 3-4v12H3z" stroke="currentColor" strokeWidth="1.2" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
      )
    case 'products':
      return (
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <rect x="3" y="7" width="18" height="13" rx="2" stroke="currentColor" strokeWidth="1.4" />
          <path d="M7 7V4h10v3" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
      )
    case 'cart':
      return (
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M6 6h15l-1.5 9h-11L6 6z" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round" />
          <circle cx="10" cy="20" r="1" fill="currentColor" />
          <circle cx="18" cy="20" r="1" fill="currentColor" />
        </svg>
      )
    case 'reports':
      return (
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M3 3v18h18" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round" />
          <path d="M21 8h-7v7" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
      )
    case 'settings':
      return (
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M12 15.5A3.5 3.5 0 1 0 12 8.5a3.5 3.5 0 0 0 0 7z" stroke="currentColor" strokeWidth="1.2" strokeLinecap="round" strokeLinejoin="round" />
          <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 1 1-4 0v-.09a1.65 1.65 0 0 0-1-1.51 1.65 1.65 0 0 0-1.82.33l-.06.06A2 2 0 1 1 2.27 18.9l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 1 1 0-4h.09c.68 0 1.28-.38 1.51-1a1.65 1.65 0 0 0-.33-1.82L4.31 5.33A2 2 0 1 1 7.14 2.5l.06.06c.5.5 1.16.75 1.82.33.43-.26.9-.4 1.4-.4.5 0 .98.14 1.4.4.66.42 1.32.17 1.82-.33l.06-.06A2 2 0 1 1 18.86 4.8l-.06.06c-.5.5-.75 1.16-.33 1.82.26.43.4.9.4 1.4 0 .5-.14.98-.4 1.4-.42.66-.17 1.32.33 1.82l.06.06A2 2 0 1 1 21 9.1l-.06.06c-.5.5-.75 1.16-.33 1.82.26.43.4.9.4 1.4v.12c0 .5-.14.98-.4 1.4z" stroke="currentColor" strokeWidth="0" />
        </svg>
      )
    default:
      return null
  }
}

export default function Sidebar() {
  const [collapsed, setCollapsed] = useState(false)
  const [cartOpen, setCartOpen] = useState(false)

  const menu = [
    { key: 'home', label: 'Home', icon: 'home' },
    { key: 'sales', label: 'Sales', icon: 'sales' },
    { key: 'products', label: 'Products', icon: 'products' },
    { key: 'cart', label: 'Cart', icon: 'cart' },
    { key: 'reports', label: 'Reports', icon: 'reports' },
    { key: 'settings', label: 'Settings', icon: 'settings' }
  ]

  return (
    <aside className={`sidebar ${collapsed ? 'collapsed' : ''}`}>
      <div className="brand">
        <div className="logo">POS</div>
        {!collapsed && <div className="brand-name">Point of Sale</div>}
        <button className="collapse-btn" onClick={() => setCollapsed(s => !s)} aria-label="Toggle sidebar">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M9 6l6 6-6 6" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round" />
          </svg>
        </button>
      </div>

      <nav className="menu">
        {menu.map(item => (
          <div key={item.key} className="menu-item" title={collapsed ? item.label : ''} onClick={() => item.key === 'cart' ? setCartOpen(true) : null}>
            <div className="icon" aria-hidden>
              <Icon name={item.icon} />
            </div>
            {!collapsed && <div className="label">{item.label}</div>}
            {item.key === 'cart' && <div className="badge">3</div>}
          </div>
        ))}
      </nav>

      <div className="sidebar-footer">
        {!collapsed && <div className="help">Need help?</div>}
      </div>

      <div className={`cart-drawer ${cartOpen ? 'open' : ''}`}>
        <div className="cart-header">
          <strong>Cart</strong>
          <button className="close" onClick={() => setCartOpen(false)} aria-label="Close cart">✕</button>
        </div>
        <div className="cart-body">
          <p style={{ marginTop: 0 }}>3 items</p>
          <ul>
            <li>Latte — $4.50</li>
            <li>Blueberry Muffin — $2.75</li>
            <li>Gift Card — $25.00</li>
          </ul>
        </div>
        <div className="cart-footer">
          <button className="primary">Checkout</button>
        </div>
      </div>
    </aside>
  )
}
