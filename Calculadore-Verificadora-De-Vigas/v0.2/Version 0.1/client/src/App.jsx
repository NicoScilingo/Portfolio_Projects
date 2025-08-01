import { useState } from "react";
import "./App.css";

function App() {
  const [formData, setFormData] = useState({
    L: "",
    P: "",
    Sx: "",
    Fy: ""
  });
  const [resultado, setResultado] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
    if (error) setError("");
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError("");
    setResultado(null);

    try {
      const res = await fetch("http://localhost:3002/api/verificar", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(formData),
      });

      const data = await res.json();

      if (!res.ok) {
        throw new Error(data.error || "Error en el servidor");
      }

      setResultado(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const isFormValid = Object.values(formData).every(value => value.trim() !== "");

  return (
    <div className="calculator-container">
      <h1 className="calculator-title">Calculadora AISC - Verificación de Vigas</h1>
      
      <form onSubmit={handleSubmit} className="input-form">
        <div className="input-group">
          <label htmlFor="L">Longitud de la viga (m)</label>
          <input
            type="number"
            id="L"
            name="L"
            value={formData.L}
            onChange={handleInputChange}
            step="0.01"
            min="0"
            placeholder="Ej: 6.0"
            required
          />
        </div>

        <div className="input-group">
          <label htmlFor="P">Carga distribuida (kN/m)</label>
          <input
            type="number"
            id="P"
            name="P"
            value={formData.P}
            onChange={handleInputChange}
            step="0.01"
            min="0"
            placeholder="Ej: 25.0"
            required
          />
        </div>

        <div className="input-group">
          <label htmlFor="Sx">Módulo de sección (cm³)</label>
          <input
            type="number"
            id="Sx"
            name="Sx"
            value={formData.Sx}
            onChange={handleInputChange}
            step="0.01"
            min="0"
            placeholder="Ej: 500.0"
            required
          />
        </div>

        <div className="input-group">
          <label htmlFor="Fy">Esfuerzo de fluencia (MPa)</label>
          <input
            type="number"
            id="Fy"
            name="Fy"
            value={formData.Fy}
            onChange={handleInputChange}
            step="0.01"
            min="0"
            placeholder="Ej: 250.0"
            required
          />
        </div>

        <button 
          type="submit" 
          className="submit-button"
          disabled={!isFormValid || loading}
        >
          {loading ? "Calculando..." : "Calcular Verificación"}
        </button>
      </form>

      {loading && (
        <div className="loading">
          ⏳ Procesando cálculo...
        </div>
      )}

      {error && (
        <div className="error-message">
          ❌ {error}
        </div>
      )}

      {resultado && (
        <div className="results-container">
          <div className={`verification-status ${
            resultado.verifica.includes("✅") 
              ? "verification-success" 
              : "verification-failure"
          }`}>
            {resultado.verifica}
          </div>

          <div className="result-item">
            <span className="result-label">Momento máximo:</span>
            <span className="result-value">{resultado.Mmax} kN·m</span>
          </div>

          <div className="result-item">
            <span className="result-label">Momento de diseño:</span>
            <span className="result-value">{resultado.Mdesign} kN·m</span>
          </div>

          <div className="result-item">
            <span className="result-label">Factor de seguridad:</span>
            <span className="result-value">{resultado.factorSeguridad}</span>
          </div>

          <div className="result-item">
            <span className="result-label">Porcentaje de utilización:</span>
            <span className="result-value">{resultado.porcentajeUtilizacion}%</span>
          </div>

          <div className="details-section">
            <div className="details-title">📋 Detalles del Cálculo</div>
            <div className="details-grid">
              <div className="detail-item">
                <span className="detail-label">Longitud:</span>
                <span className="detail-value">{resultado.detalles.longitud}</span>
              </div>
              <div className="detail-item">
                <span className="detail-label">Carga:</span>
                <span className="detail-value">{resultado.detalles.carga}</span>
              </div>
              <div className="detail-item">
                <span className="detail-label">Módulo de sección:</span>
                <span className="detail-value">{resultado.detalles.moduloSeccion}</span>
              </div>
              <div className="detail-item">
                <span className="detail-label">Esfuerzo de fluencia:</span>
                <span className="detail-value">{resultado.detalles.esfuerzoFluencia}</span>
              </div>
              <div className="detail-item">
                <span className="detail-label">Factor de reducción (φ):</span>
                <span className="detail-value">{resultado.detalles.factorReduccion}</span>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

export default App;
