import './App.css'

function App() {
  return (
    <div className="login-page">
      <div className="login-card">
        <div className="login-header">
          <div className="header-icon" aria-hidden="true">🔒</div>
          <h1>Login</h1>
        </div>

        <form className="login-form" onSubmit={(event) => event.preventDefault()}>
          <label className="input-group">
            <div className="input-wrapper">
              <span className="input-icon user-icon" aria-hidden="true"></span>
              <input
                type="text"
                name="username"
                placeholder="Username"
                autoComplete="username"
                required
              />
            </div>
          </label>

          <label className="input-group">
            <div className="input-wrapper">
              <span className="input-icon lock-icon" aria-hidden="true"></span>
              <input
                type="password"
                name="password"
                placeholder="Password"
                autoComplete="current-password"
                required
              />
            </div>
          </label>

          <button className="login-button" type="submit">
            Login
          </button>
        </form>
      </div>
    </div>
  )
}

export default App
