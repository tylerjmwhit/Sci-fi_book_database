// Importing required modules
const defaultRouter = require('./routes/default')
const koa = require('koa');
const koajson = require('koa-json');
const koabodyparser = require('koa-bodyparser');

// Creating a new Koa instance
const api = new koa();

// Middleware for logging request information
api.use(async (ctx, next) => {
    await next();
    const rt = ctx.response.get('X-Response-Time');
    console.log(`Type: ${ctx.method} Path: ${ctx.url} Time: ${rt}`)
});

// Middleware for measuring response time
api.use(async (ctx, next) => {
    const start = Date.now();
    await next();
    const time = Date.now() - start;
    ctx.set('X-Response-Time', `${time} ms`);
});

// Middleware for parsing JSON requests 
// and for parsing request bodies
api.use(koajson());
api.use(koabodyparser());

// Middleware for handling errors
api.use(async (ctx, next) => {
    try {
        await next();
    } catch (e) {
        console.error(e);
    }
});

defaultRouter(api);
api.listen(8067);