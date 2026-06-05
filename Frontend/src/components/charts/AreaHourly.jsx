import React from 'react'
import { ResponsiveContainer, AreaChart, Area, XAxis, YAxis, Tooltip, CartesianGrid } from 'recharts'

const data = Array.from({ length: 12 }).map((_, i) => ({
  hour: `${8 + i}:00`,
  sales: Math.round(400 + Math.random() * 1600)
}))

export default function AreaHourly() {
  return (
    <div style={{ width: '100%', height: 240 }}>
      <ResponsiveContainer>
        <AreaChart data={data} margin={{ top: 8, right: 16, left: 0, bottom: 0 }}>
          <defs>
            <linearGradient id="areaGrad" x1="0" y1="0" x2="0" y2="1">
              <stop offset="0%" stopColor="#34d399" stopOpacity={0.6} />
              <stop offset="100%" stopColor="#34d399" stopOpacity={0.04} />
            </linearGradient>
          </defs>
          <CartesianGrid strokeDasharray="3 3" stroke="rgba(15,23,42,0.04)" />
          <XAxis dataKey="hour" stroke="#64748b" />
          <YAxis stroke="#64748b" />
          <Tooltip />
          <Area type="monotone" dataKey="sales" stroke="#10b981" fill="url(#areaGrad)" strokeWidth={2} />
        </AreaChart>
      </ResponsiveContainer>
    </div>
  )
}
