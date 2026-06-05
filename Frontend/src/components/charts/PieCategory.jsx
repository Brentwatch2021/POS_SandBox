import React from 'react'
import { ResponsiveContainer, PieChart, Pie, Cell, Tooltip } from 'recharts'

const data = [
  { name: 'Beverages', value: 42000 },
  { name: 'Food', value: 91000 },
  { name: 'Merch', value: 21000 },
  { name: 'Services', value: 12000 }
]

const COLORS = ['#06b6d4', '#7c3aed', '#f59e0b', '#10b981']

export default function PieCategory() {
  return (
    <div style={{ width: '100%', height: 240, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
      <ResponsiveContainer>
        <PieChart>
          <Pie data={data} dataKey="value" nameKey="name" cx="50%" cy="50%" outerRadius={70} innerRadius={38} paddingAngle={4}>
            {data.map((entry, index) => (
              <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
            ))}
          </Pie>
          <Tooltip />
        </PieChart>
      </ResponsiveContainer>
    </div>
  )
}
