//ROTAS DE POSTAR NOVOS LIVROS 
const express = require('express');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const db = require('../config/database');
const router = express.Router();
const cors = require('cors');
const { criptografarSenha, compararSenha } = require('../middlewares/auth');



//ROTA DE POSTAR NOVO CLIENTE
// Exemplo de rota de cadastro
router.post('/cadastro', async (req, res) => {
    const { nome, email, telefone, senha } = req.body;
  
    if (!nome || !email || !telefone || !senha) {
      return res.status(400).json({ error: 'Preencha todos os campos!' });
    }
  
    // Verifica se o email já está cadastrado
    const sqlVerificarEmail = 'SELECT * FROM cliente WHERE email = ?';
    db.query(sqlVerificarEmail, [email], async (err, results) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ error: 'Erro ao verificar o email' });
      }
  
      if (results.length > 0) {
        return res.status(400).json({ error: 'Email já está em uso!' });
      }
  
      // Criptografa a senha antes de armazenar
      const senhaHash = await criptografarSenha(senha);
  
      const sqlInserir = 'INSERT INTO cliente (nome,email,telefone,senha) VALUES (?,?,?,?)';
      db.query(sqlInserir, [nome, email, telefone, senhaHash], (err, result) => {
        if (err) {
          console.error(err);
          return res.status(500).json({ error: 'Erro ao cadastrar o usuário' });
        }
        return res.status(201).json({ message: 'Cliente cadastrado com sucesso!' });
      });
    });
  });
  

module.exports = router;