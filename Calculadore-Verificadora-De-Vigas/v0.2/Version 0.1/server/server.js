const express = require('express');
const cors = require('cors');
const app = express();
const PORT = 3002;

app.use(cors());
app.use(express.json());

app.post('/api/verificar', (req, res) => {
    try {
        const { L, P, Sx, Fy } = req.body;

        // Validaciones
        if (!L || !P || !Sx || !Fy) {
            return res.status(400).json({ 
                error: "Todos los campos son requeridos" 
            });
        }

        if (L <= 0 || P <= 0 || Sx <= 0 || Fy <= 0) {
            return res.status(400).json({ 
                error: "Todos los valores deben ser positivos" 
            });
        }

        // Conversión de unidades
        const Lm = parseFloat(L); // m
        const PkN = parseFloat(P); // kN/m
        const Sx_m3 = parseFloat(Sx) / 1e6; // cm³ → m³
        const Fy_kN_m2 = parseFloat(Fy) * 1000; // MPa → kN/m²

        // Cálculo momento máximo
        const Mmax = (PkN * Math.pow(Lm, 2)) / 8; // kN·m

        // Momento resistente
        const Mn = Fy_kN_m2 * Sx_m3; // kN·m
        const phi = 0.9;
        const Mdesign = phi * Mn;

        const verifica = Mmax <= Mdesign;
        const factorSeguridad = Mdesign / Mmax;
        const porcentajeUtilizacion = (Mmax / Mdesign) * 100;

        res.json({
            Mmax: Mmax.toFixed(2),
            Mdesign: Mdesign.toFixed(2),
            factorSeguridad: factorSeguridad.toFixed(2),
            porcentajeUtilizacion: porcentajeUtilizacion.toFixed(1),
            verifica: verifica ? "✅ Verifica" : "❌ No verifica",
            detalles: {
                longitud: Lm + " m",
                carga: PkN + " kN/m",
                moduloSeccion: Sx + " cm³",
                esfuerzoFluencia: Fy + " MPa",
                factorReduccion: phi
            }
        });
    } catch (error) {
        res.status(500).json({ 
            error: "Error en el cálculo: " + error.message 
        });
    }
});

// Ruta de sanity check
app.get('/', (req, res) => {
  res.send('API de Verificación de Vigas AISC está funcionando');
});


app.listen(PORT, () => {
    console.log(`Servidor corriendo en puerto ${PORT}`);
});
