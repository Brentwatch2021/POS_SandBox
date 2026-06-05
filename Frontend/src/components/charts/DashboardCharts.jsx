import React from 'react'
import LineSales from './LineSales'
import BarVoided from './BarVoided'
import PieCategory from './PieCategory'
import AreaHourly from './AreaHourly'
import './Charts.css'

export default function DashboardCharts() {
  return (
    <section className="charts-grid">
      <div className="chart-card">
        <h3>Daily Sales</h3>
        <LineSales />
      </div>

      <div className="chart-card">
        <h3>Voided Transactions</h3>
        <BarVoided />
      </div>

      <div className="chart-card">
        <h3>Sales by Category</h3>
        <PieCategory />
      </div>

      <div className="chart-card">
        <h3>Hourly Sales</h3>
        <AreaHourly />
      </div>
    </section>
  )
}
