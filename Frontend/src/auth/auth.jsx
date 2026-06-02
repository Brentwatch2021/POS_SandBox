import axios from 'axios';

const API_BASE = 'https://localhost:7051/api/Auth';

export const login = async (Email_Username, password) => {
  const response = await axios.post(`${API_BASE}/login`,{
  "email_Username": Email_Username,
  "password": password
});
  return response.data;
};
