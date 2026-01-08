import { useState, useEffect } from 'react'
import './App.css'

function App() {
  const [systolic, setSystolic] = useState('')
  const [diastolic, setDiastolic] = useState('')
  const [pulse, setPulse] = useState('')
  const [readings, setReadings] = useState([])
  const [classification, setClassification] = useState(null)

  useEffect(() => {
    // Load readings from localStorage
    const savedReadings = localStorage.getItem('bloodPressureReadings')
    if (savedReadings) {
      setReadings(JSON.parse(savedReadings))
    }
  }, [])

  const classifyBloodPressure = (sys, dia) => {
    sys = parseInt(sys, 10)
    dia = parseInt(dia, 10)

    if (sys > 180 || dia > 120) {
      return { level: 'Crisis Hipertensiva', color: '#991b1b', description: '¡Busque atención médica de emergencia!' }
    } else if (sys >= 140 || dia >= 90) {
      return { level: 'Hipertensión Etapa 2', color: '#ef4444', description: 'Consulte a su médico urgentemente' }
    } else if ((sys >= 130 && sys <= 139) || (dia >= 80 && dia <= 89)) {
      return { level: 'Hipertensión Etapa 1', color: '#f97316', description: 'Consulte a su médico' }
    } else if (sys >= 120 && sys <= 129 && dia < 80) {
      return { level: 'Elevada', color: '#f59e0b', description: 'Presión arterial elevada' }
    } else if (sys < 120 && dia < 80) {
      return { level: 'Normal', color: '#10b981', description: 'Presión arterial normal' }
    }
    return null
  }

  const handleSubmit = (e) => {
    e.preventDefault()
    
    if (!systolic || !diastolic) {
      alert('Por favor ingrese los valores de presión arterial')
      return
    }

    const newReading = {
      id: crypto.randomUUID(),
      systolic: parseInt(systolic, 10),
      diastolic: parseInt(diastolic, 10),
      pulse: pulse ? parseInt(pulse, 10) : null,
      date: new Date().toLocaleString('es-ES'),
      classification: classifyBloodPressure(systolic, diastolic)
    }

    const updatedReadings = [newReading, ...readings].slice(0, 10) // Keep last 10 readings
    setReadings(updatedReadings)
    localStorage.setItem('bloodPressureReadings', JSON.stringify(updatedReadings))

    setClassification(newReading.classification)
    setSystolic('')
    setDiastolic('')
    setPulse('')
  }

  const deleteReading = (id) => {
    const updatedReadings = readings.filter(reading => reading.id !== id)
    setReadings(updatedReadings)
    localStorage.setItem('bloodPressureReadings', JSON.stringify(updatedReadings))
  }

  return (
    <div className="app">
      <header className="header">
        <h1>🩺 Monitor de Tensión Arterial</h1>
        <p>Registra y monitorea tu presión arterial</p>
      </header>

      <div className="container">
        <div className="input-section">
          <h2>Nueva Lectura</h2>
          <form onSubmit={handleSubmit}>
            <div className="input-group">
              <label htmlFor="systolic">
                Presión Sistólica (mmHg)
                <span className="input-hint">Valor superior</span>
              </label>
              <input
                type="number"
                id="systolic"
                value={systolic}
                onChange={(e) => setSystolic(e.target.value)}
                placeholder="120"
                min="70"
                max="250"
              />
            </div>

            <div className="input-group">
              <label htmlFor="diastolic">
                Presión Diastólica (mmHg)
                <span className="input-hint">Valor inferior</span>
              </label>
              <input
                type="number"
                id="diastolic"
                value={diastolic}
                onChange={(e) => setDiastolic(e.target.value)}
                placeholder="80"
                min="40"
                max="150"
              />
            </div>

            <div className="input-group">
              <label htmlFor="pulse">
                Pulso (ppm) - Opcional
                <span className="input-hint">Pulsaciones por minuto</span>
              </label>
              <input
                type="number"
                id="pulse"
                value={pulse}
                onChange={(e) => setPulse(e.target.value)}
                placeholder="70"
                min="40"
                max="200"
              />
            </div>

            <button type="submit" className="submit-btn">
              Registrar Lectura
            </button>
          </form>

          {classification && (
            <div className="classification-result" style={{ borderColor: classification.color }}>
              <h3 style={{ color: classification.color }}>{classification.level}</h3>
              <p>{classification.description}</p>
            </div>
          )}
        </div>

        <div className="history-section">
          <h2>Historial de Lecturas</h2>
          
          {readings.length === 0 ? (
            <div className="empty-state">
              <p>No hay lecturas registradas</p>
              <p className="empty-hint">Registra tu primera lectura para comenzar</p>
            </div>
          ) : (
            <div className="readings-list">
              {readings.map((reading) => (
                <div key={reading.id} className="reading-card">
                  <div className="reading-header">
                    <div className="reading-date">{reading.date}</div>
                    <button 
                      onClick={() => deleteReading(reading.id)}
                      className="delete-btn"
                      aria-label="Eliminar lectura"
                    >
                      ×
                    </button>
                  </div>
                  <div className="reading-values">
                    <div className="value-item">
                      <span className="value-label">Sistólica</span>
                      <span className="value-number">{reading.systolic}</span>
                    </div>
                    <div className="separator">/</div>
                    <div className="value-item">
                      <span className="value-label">Diastólica</span>
                      <span className="value-number">{reading.diastolic}</span>
                    </div>
                    {reading.pulse && (
                      <>
                        <div className="separator">•</div>
                        <div className="value-item">
                          <span className="value-label">Pulso</span>
                          <span className="value-number">{reading.pulse}</span>
                        </div>
                      </>
                    )}
                  </div>
                  {reading.classification && (
                    <div 
                      className="reading-classification"
                      style={{ backgroundColor: reading.classification.color + '20', color: reading.classification.color }}
                    >
                      {reading.classification.level}
                    </div>
                  )}
                </div>
              ))}
            </div>
          )}
        </div>
      </div>

      <div className="reference-guide">
        <h3>Guía de Referencia</h3>
        <div className="reference-grid">
          <div className="reference-item">
            <div className="reference-color" style={{ backgroundColor: '#10b981' }}></div>
            <div className="reference-info">
              <strong>Normal</strong>
              <span>&lt;120 / &lt;80</span>
            </div>
          </div>
          <div className="reference-item">
            <div className="reference-color" style={{ backgroundColor: '#f59e0b' }}></div>
            <div className="reference-info">
              <strong>Elevada</strong>
              <span>120-129 / &lt;80</span>
            </div>
          </div>
          <div className="reference-item">
            <div className="reference-color" style={{ backgroundColor: '#f97316' }}></div>
            <div className="reference-info">
              <strong>Hipertensión Etapa 1</strong>
              <span>130-139 / 80-89</span>
            </div>
          </div>
          <div className="reference-item">
            <div className="reference-color" style={{ backgroundColor: '#ef4444' }}></div>
            <div className="reference-info">
              <strong>Hipertensión Etapa 2</strong>
              <span>≥140 / ≥90</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

export default App
