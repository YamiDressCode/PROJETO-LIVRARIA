const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');  // Importando o bcryptjs
const db = require('../config/database'); // Sua conexão com o banco

// Middleware para verificar se o usuário está autenticado
const autenticar = (req, res, next) => {
    const authHeader = req.header('Authorization');
  
    if (!authHeader) {
      return res.status(403).json({ error: 'Acesso negado! Token não fornecido.' });
    }
  
    // Removendo o prefixo "Bearer " para obter apenas o token
    const token = authHeader.split(' ')[1];
  
    if (!token) {
      return res.status(403).json({ error: 'Acesso negado! Token inválido.' });
    }
  
    try {
      const decoded = jwt.verify(token, 'seu-segredo-aqui'); // Verifica o token com o segredo
      req.user = decoded; // Adiciona os dados do token à requisição
      next(); // Passa para o próximo middleware ou rota
    } catch (err) {
      return res.status(400).json({ error: 'Token inválido.' });
    }
  };
  

// Middleware para verificar se o usuário é administrador
const verificarAdministrador = (req, res, next) => {
  // Vamos assumir que você armazena o campo "role" dentro do payload do token JWT
  const { user } = req; // O objeto "user" foi salvo no middleware de autenticação

  if (user.role !== 'admin') {
    return res.status(403).json({ error: 'Acesso negado! Você não tem permissão de administrador.' });
  }

  next(); // Se for admin, passa para a próxima função (a rota ou outro middleware)
};

// Função para comparar a senha fornecida com a senha armazenada no banco (geralmente usada no login)
const compararSenha = async (senhaFornecida, senhaArmazenada) => {
  try {
    return await bcrypt.compare(senhaFornecida, senhaArmazenada); // Compara a senha fornecida com a armazenada
  } catch (err) {
    throw new Error('Erro ao comparar as senhas');
  }
};

// Função para criptografar a senha antes de armazená-la no banco de dados (geralmente usada no cadastro)
const criptografarSenha = async (senha) => {
  try {
    const senhaHash = await bcrypt.hash(senha, 10); // Cria o hash da senha
    return senhaHash;
  } catch (err) {
    throw new Error('Erro ao criptografar a senha');
  }
};

// Exportando os middlewares para serem utilizados nas rotas
module.exports = {
  autenticar,
  verificarAdministrador,
  compararSenha, // Função para comparar a senha no login
  criptografarSenha // Função para criptografar a senha no cadastro
};
