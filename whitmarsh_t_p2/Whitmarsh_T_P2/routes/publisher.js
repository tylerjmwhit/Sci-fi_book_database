const publisherController = require('../controllers/publisher');

const publisherRouter = require('koa-router')({
    prefix: '/publisher'
});

// GET /publisher - Route to get all publishers
publisherRouter.get('/', publisherController.getpublishers);

// GET /publisher/phonenumber/:name - Route to get phone numbers of a specific publisher
publisherRouter.get('/phonenumber/:name', publisherController.getPhonenumbers);

// GET /publisher/:name - Route to get a publisher by name
publisherRouter.get('/:name', publisherController.getPublisherByName);

module.exports = publisherRouter;