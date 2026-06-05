import React from 'react'
import { ResponsiveContainer, LineChart, Line, XAxis, YAxis, Tooltip, CartesianGrid } from 'recharts'

const data = [
  { day: 'Mon', sales: 4200 },
  { day: 'Tue', sales: 5300 },
  { day: 'Wed', sales: 4800 },
  { day: 'Thu', sales: 6100 },
  { day: 'Fri', sales: 7600 },
  { day: 'Sat', sales: 8900 },
  { day: 'Sun', sales: 7200 }
]

export default function LineSales() {
  return (
    <div style={{ width: '100%', height: 240 }}>
      <ResponsiveContainer>
        <LineChart data={data} margin={{ top: 8, right: 16, left: 0, bottom: 0 }}>
          <defs>
            <linearGradient id="grad" x1="0" y1="0" x2="0" y2="1">
              <stop offset="0%" stopColor="#60a5fa" stopOpacity={0.6} />
              <stop offset="100%" stopColor="#60a5fa" stopOpacity={0.05} />
            </linearGradient>
          </defs>
          <CartesianGrid strokeDasharray="3 3" stroke="rgba(15,23,42,0.06)" />
          <XAxis dataKey="day" stroke="#64748b" />
          <YAxis stroke="#64748b" />
          <Tooltip />
          <Line type="monotone" dataKey="sales" stroke="#2563eb" fillOpacity={1} fill="url(#grad)" strokeWidth={3} dot={{ r: 4 }} />
        </LineChart>
      </ResponsiveContainer>
    </div>
  )
}
