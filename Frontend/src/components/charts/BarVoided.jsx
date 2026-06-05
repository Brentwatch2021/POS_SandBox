import React from 'react'
import { ResponsiveContainer, BarChart, Bar, XAxis, YAxis, Tooltip, CartesianGrid } from 'recharts'

const data = [
  { day: 'Mon', voided: 2 },
  { day: 'Tue', voided: 1 },
  { day: 'Wed', voided: 3 },
  { day: 'Thu', voided: 0 },
  { day: 'Fri', voided: 4 },
  { day: 'Sat', voided: 5 },
  { day: 'Sun', voided: 2 }
]

export default function BarVoided() {
  return (
    <div style={{ width: '100%', height: 240 }}>
      <ResponsiveContainer>
        <BarChart data={data} margin={{ top: 8, right: 16, left: 0, bottom: 0 }}>
          <CartesianGrid strokeDasharray="3 3" stroke="rgba(15,23,42,0.04)" />
          <XAxis dataKey="day" stroke="#64748b" />
          <YAxis stroke="#64748b" allowDecimals={false} />
          <Tooltip />
          <Bar dataKey="voided" fill="#ef4444" radius={[6,6,0,0]} />
        </BarChart>
      </ResponsiveContainer>
    </div>
  )
}
