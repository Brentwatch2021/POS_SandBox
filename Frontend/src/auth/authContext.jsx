import { createContext, useContext, useState, useEffect } from "react";

const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);

  useEffect(() => {
    const token = localStorage.getItem("token");
    const userId = localStorage.getItem("userId");
    const storeId = localStorage.getItem("storeId");
    const fullName = localStorage.getItem("fullName");

    if (token) {
      setUser({ token, userId, storeId, fullName });
    }
  }, []);

  const login = (token) => {
    localStorage.setItem("token", token);
    setUser({ token, userId: null, storeId: null, fullName: null });
  };

  const setUserClaims = ({ userId, storeId, fullName }) => {
    if (userId) {
      localStorage.setItem("userId", userId);
    }
    if (storeId) {
      localStorage.setItem("storeId", storeId);
    }
    if (fullName) {
      localStorage.setItem("fullName", fullName);
    }

    setUser((current) => ({
      ...current,
      userId: userId ?? current?.userId,
      storeId: storeId ?? current?.storeId,
      fullName: fullName ?? current?.fullName,
    }));
  };

  const logout = () => {
    localStorage.removeItem("token");
    localStorage.removeItem("userId");
    localStorage.removeItem("storeId");
    localStorage.removeItem("fullName");
    setUser(null);
  };

  return (
    <AuthContext.Provider value={{ user, login, logout, setUserClaims }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => useContext(AuthContext);
