const express = require('express');
const db = require('../config/database');
const router = express.Router();

// Rota para buscar livros pelo parâmetro na URL
router.get('/livro/:parametro', (req, res) => {
  const { parametro } = req.params;

  // Ajusta o parâmetro para busca parcial e ignora diferenças de caixa
  const searchParam = `%${parametro}%`;

  const sql = `
    SELECT * 
    FROM livro 
    WHERE LOWER(genero) LIKE LOWER(?) 
       OR LOWER(autor) LIKE LOWER(?) 
       OR LOWER(titulo) LIKE LOWER(?)
  `;

  // Executa a consulta com o parâmetro ajustado
  db.query(sql, [searchParam, searchParam, searchParam], (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ message: 'Erro ao buscar livros.' });
    }

    if (results.length === 0) {
      return res.status(404).json({ message: 'Nenhum livro encontrado com os critérios informados.' });
    }

    // Retorna os livros encontrados
    res.json(results);
  });
});

module.exports = router;
