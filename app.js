// Blood Pressure Monitor Application
class BloodPressureMonitor {
    constructor() {
        this.readings = this.loadReadings();
        this.init();
    }

    init() {
        // Set current datetime as default
        const now = new Date();
        const datetime = new Date(now.getTime() - now.getTimezoneOffset() * 60000)
            .toISOString()
            .slice(0, 16);
        document.getElementById('datetime').value = datetime;

        // Event listeners
        document.getElementById('bp-form').addEventListener('submit', (e) => {
            e.preventDefault();
            this.addReading();
        });

        document.getElementById('clear-history').addEventListener('click', () => {
            this.clearHistory();
        });

        // Display existing data
        this.updateDisplay();
    }

    addReading() {
        const systolic = parseInt(document.getElementById('systolic').value);
        const diastolic = parseInt(document.getElementById('diastolic').value);
        const pulse = parseInt(document.getElementById('pulse').value) || null;
        const datetime = document.getElementById('datetime').value;
        const notes = document.getElementById('notes').value;

        const reading = {
            id: Date.now(),
            systolic,
            diastolic,
            pulse,
            datetime,
            notes,
            timestamp: new Date(datetime).getTime()
        };

        this.readings.unshift(reading);
        this.saveReadings();
        this.updateDisplay();

        // Reset form
        document.getElementById('bp-form').reset();
        const now = new Date();
        const newDatetime = new Date(now.getTime() - now.getTimezoneOffset() * 60000)
            .toISOString()
            .slice(0, 16);
        document.getElementById('datetime').value = newDatetime;

        // Show success message
        this.showNotification('Medición guardada correctamente');
    }

    deleteReading(id) {
        this.readings = this.readings.filter(r => r.id !== id);
        this.saveReadings();
        this.updateDisplay();
        this.showNotification('Medición eliminada');
    }

    clearHistory() {
        if (this.readings.length === 0) {
            this.showNotification('No hay mediciones para eliminar');
            return;
        }

        if (confirm('¿Estás seguro de que deseas eliminar todo el historial?')) {
            this.readings = [];
            this.saveReadings();
            this.updateDisplay();
            this.showNotification('Historial limpiado');
        }
    }

    updateDisplay() {
        this.updateStatusDisplay();
        this.updateHistoryDisplay();
    }

    updateStatusDisplay() {
        const statusDiv = document.getElementById('status-display');
        
        if (this.readings.length === 0) {
            statusDiv.innerHTML = '<p>No hay mediciones registradas aún.</p>';
            return;
        }

        const latest = this.readings[0];
        const category = this.getBloodPressureCategory(latest.systolic, latest.diastolic);
        const date = new Date(latest.datetime).toLocaleString('es-ES', {
            dateStyle: 'long',
            timeStyle: 'short'
        });

        statusDiv.innerHTML = `
            <h3>Última Medición</h3>
            <p><strong>Fecha:</strong> ${date}</p>
            <p><strong>Presión:</strong> ${latest.systolic}/${latest.diastolic} mmHg</p>
            ${latest.pulse ? `<p><strong>Pulso:</strong> ${latest.pulse} ppm</p>` : ''}
            <span class="status-badge status-${category.class}">${category.label}</span>
            <p style="margin-top: 15px;"><small>${category.description}</small></p>
        `;
    }

    updateHistoryDisplay() {
        const historyDiv = document.getElementById('history-list');
        
        if (this.readings.length === 0) {
            historyDiv.innerHTML = '<p class="no-data">No hay mediciones en el historial.</p>';
            return;
        }

        historyDiv.innerHTML = this.readings.map(reading => {
            const date = new Date(reading.datetime).toLocaleString('es-ES', {
                dateStyle: 'medium',
                timeStyle: 'short'
            });
            const category = this.getBloodPressureCategory(reading.systolic, reading.diastolic);

            return `
                <div class="history-item">
                    <div class="history-item-header">
                        <span class="history-item-date">${date}</span>
                        <button class="history-item-delete" onclick="monitor.deleteReading(${reading.id})">
                            Eliminar
                        </button>
                    </div>
                    <div class="history-item-data">
                        <p><strong>Presión:</strong> ${reading.systolic}/${reading.diastolic} mmHg</p>
                        ${reading.pulse ? `<p><strong>Pulso:</strong> ${reading.pulse} ppm</p>` : ''}
                        <p><strong>Estado:</strong> <span class="status-badge status-${category.class}">${category.label}</span></p>
                        ${reading.notes ? `<p><strong>Notas:</strong> ${reading.notes}</p>` : ''}
                    </div>
                </div>
            `;
        }).join('');
    }

    getBloodPressureCategory(systolic, diastolic) {
        if (systolic < 120 && diastolic < 80) {
            return {
                label: 'Normal',
                class: 'normal',
                description: 'Tu presión arterial está en un rango saludable.'
            };
        } else if (systolic >= 120 && systolic < 130 && diastolic < 80) {
            return {
                label: 'Elevada',
                class: 'elevated',
                description: 'Tu presión está ligeramente elevada. Considera cambios en el estilo de vida.'
            };
        } else if ((systolic >= 130 && systolic < 140) || (diastolic >= 80 && diastolic < 90)) {
            return {
                label: 'Hipertensión Etapa 1',
                class: 'high',
                description: 'Consulta con tu médico sobre cambios en el estilo de vida y posible medicación.'
            };
        } else if (systolic >= 140 || diastolic >= 90) {
            return {
                label: 'Hipertensión Etapa 2',
                class: 'high',
                description: 'Consulta con tu médico. Puede ser necesaria medicación.'
            };
        } else if (systolic > 180 || diastolic > 120) {
            return {
                label: 'Crisis Hipertensiva',
                class: 'high',
                description: '⚠️ Busca atención médica inmediata.'
            };
        }
        
        return {
            label: 'Desconocido',
            class: 'normal',
            description: 'Consulta con un profesional de la salud.'
        };
    }

    loadReadings() {
        try {
            const data = localStorage.getItem('bloodPressureReadings');
            return data ? JSON.parse(data) : [];
        } catch (error) {
            console.error('Error loading readings:', error);
            return [];
        }
    }

    saveReadings() {
        try {
            localStorage.setItem('bloodPressureReadings', JSON.stringify(this.readings));
        } catch (error) {
            console.error('Error saving readings:', error);
            this.showNotification('Error al guardar los datos');
        }
    }

    showNotification(message) {
        const notification = document.createElement('div');
        notification.textContent = message;
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            background: #27ae60;
            color: white;
            padding: 15px 25px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            z-index: 1000;
            animation: slideIn 0.3s ease-out;
        `;
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.style.animation = 'slideOut 0.3s ease-out';
            setTimeout(() => notification.remove(), 300);
        }, 2000);
    }
}

// Initialize the application
const monitor = new BloodPressureMonitor();

// Add CSS animations
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOut {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(100%);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);
