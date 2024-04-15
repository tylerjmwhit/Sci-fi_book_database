const authorRouter = require('./author');
const bookRouter = require('./book');
const publisherRouter = require('./publisher');

// Setting a prefix for all routes in this router
const router = require('koa-router')({
    prefix:'/api/v1'
});
// Attaching the imported routers to the main router
router.use(
    authorRouter.routes(),
    bookRouter.routes(),
    publisherRouter.routes(),
);
module.exports = (api) => {
    api.use(router.routes());
};