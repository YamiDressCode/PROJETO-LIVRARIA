
// INICIANDO SERVIDOR
const express = require('express');
const comprasRoutes = require('./routes/compras');
const admRoutes = require('./routes/adm');
const pesquisarRoutes = require('./routes/pesquisar');
const cadastroRoutes = require('./routes/cadastro');
const loginRoutes = require('./routes/login');
const cors = require('cors');
const app = express();


// Middleware para ler o corpo da requisição
app.use(express.json());
app.use(cors()); 

// Usar as rotas de compras
app.use(comprasRoutes);

app.use(admRoutes);

app.use(pesquisarRoutes);

app.use(cadastroRoutes);

app.use(loginRoutes);



// Iniciar o servidor
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});