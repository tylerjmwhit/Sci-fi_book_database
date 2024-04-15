const bookController = require('../controllers/book');

const bookRouter = require('koa-router')({
    prefix: '/book' // Setting a prefix for all routes in this router
});

// GET /book - Route to get all books
bookRouter.get('/', bookController.getBooks);

// GET /book/BestReviewed - Route to get the best reviewed books
bookRouter.get('/BestReviewed', bookController.getBestReviewed);

// GET /book/AverageReview - Route to get the average review of books
bookRouter.get('/AverageReview', bookController.getAverageReview);

// GET /book/:title/:author - Route to get books by title and author
bookRouter.get('/:title/:author', bookController.getBooksByKey);

// PUT /book/:title/:author - Route to update a book by title and author
bookRouter.put('/:title/:author', bookController.updateBookByKey);

// POST /book - Route to add a new book
bookRouter.post('/', bookController.addBook);

// DELETE /book/:title/:author - Route to delete a book by title and author
bookRouter.delete('/:title/:author', bookController.deleteBookByKey);

module.exports = bookRouter;