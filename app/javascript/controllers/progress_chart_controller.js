import { Controller } from "@hotwired/stimulus"
import Chart from "chart.js/auto"

// Connects to data-controller="progress-chart"
export default class extends Controller {
  static targets = ["select", "canvas", "emptyState"]
  connect() {
    // chart instance here so we can destroy and redraw it when the user picks a new exercise
    this.chart = null
  }
  async load() {
    const exerciseId = this.selectTarget.value

    // If the user selects the default "Select an exercise..." option, clear the chart
    if (!exerciseId) {
      this.clearChart()
      return
    }

    try {
      //Make  API Call to the Rails endpoint 
      const response = await fetch(`/api/v1/progress?exercise_id=${exerciseId}`)
      
      if (!response.ok) throw new Error("Network response was not ok")
      
      //Parse  JSON data
      const data = await response.json()
      
      // draw chart
      this.drawChart(data)
    } catch (error) {
      console.error("Failed to fetch chart data:", error)
    }
  }

  drawChart(data) {
    //Hide "Select an exercise" text
    if (this.hasEmptyStateTarget) {
      this.emptyStateTarget.classList.add("hidden")
    }

    //Destroy the old chart before drawing a new one
    if (this.chart) {
      this.chart.destroy()
    }

    // Get HTML canvas element
    const ctx = this.canvasTarget.getContext("2d")

    // B Chart.js line graph
    this.chart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: data.labels, // The dates array from  API
        datasets: [{
          label: 'Max Weight (lbs)',
          data: data.data,   // The weights array from  API
          borderColor: 'rgb(37, 99, 235)', 
          backgroundColor: 'rgba(37, 99, 235, 0.1)',
          borderWidth: 3,
          pointBackgroundColor: 'rgb(37, 99, 235)',
          pointRadius: 5,
          fill: true,
          tension: 0.3 
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: false,
            title: { display: true, text: 'Weight (lbs)' }
          }
        }
      }
    })
  }

  clearChart() {
    if (this.chart) {
      this.chart.destroy()
      this.chart = null
    }
    if (this.hasEmptyStateTarget) {
      this.emptyStateTarget.classList.remove("hidden")
    }
  }
}
