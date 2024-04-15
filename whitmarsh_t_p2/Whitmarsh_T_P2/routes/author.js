const authorController = require('../controllers/author');

const authorRouter = require('koa-router')({
    prefix: '/author' // Setting a prefix for all routes in this router
});

// GET /author - Route to get all authors
authorRouter.get('/', authorController.getAuthors);

// GET /author/awards - Route to get total awards of authors
authorRouter.get('/awards', authorController.getTotalAwards);

// GET /author/reviews - Route to get average review score of authors
authorRouter.get('/reviews', authorController.getAverageReview);

// GET /author/bestReviewed/:name - Route to get best reviewed book of a specific author
authorRouter.get('/bestReviewed/:name', authorController.getbestReview);

// GET /author/:name - Route to get an author by name
authorRouter.get('/:name', authorController.getAuthorByName);

// PUT /author/:name - Route to update an author by name
authorRouter.put('/:name', authorController.updateAuthor);

// DELETE /author/:name - Route to delete an author by name
authorRouter.delete('/:name', authorController.deleteAuthorByName);

// POST /author - Route to add a new author
authorRouter.post('/', authorController.addAuthor);


module.exports = authorRouter;
