const db = require('../database/connection');

class authorController{
    // Method to get all authors
    static getAuthors(ctx){
        return new Promise((resolve,reject) =>{
            const query = 'Select * FROM BD_Author;';
            db.query(query, (err,res) => {
                if(err) {
                    reject(err);
                }
                ctx.body = res;
                resolve();
            });
        });
    }
    // Method to update an author by name
    static updateAuthor(ctx){
        return new Promise((resolve, reject) => {
            const author = ctx.request.body;
            const query = `
                UPDATE BD_Author
                SET Email = ?
                WHERE Name like ?;
            `;

            db.query({
                sql: query,
                values: [author.email, ctx.params.name]
            }, (err, res)=>{
                if(err) {
                    reject(err);
                }
                ctx.status = 200;
                resolve()
            });
        })
    }
    // Method to add a new author
    static addAuthor(ctx) {
        return new Promise((resolve, reject) => {
            const author = ctx.request.body;
            const query =  `
                INSERT INTO BD_Author (Name, Email)
                VALUES (?, ?);
            `;
            db.query({
                sql: query,
                values: [author.name, author.email]
            }, (err, res) => {
                if(err) {
                    reject(err);
                }
                ctx.status = 201;
                resolve();
            });
        });
    }
    // Method to delete an author by name
    static deleteAuthorByName(ctx) {
        return new Promise((resolve, reject) => {
            const query = 'DELETE FROM BD_Author WHERE Name like ?;'; 
            db.query({
                sql: query,
                values: [ ctx.params.name]
            }, (err,res) => {
                if(err) {
                    reject(err);
                }
                ctx.body = res;
                resolve();
            });
        });
    }
    // Method to get an author by name
    static getAuthorByName(ctx){
        return new Promise((resolve,reject) =>{
            const query = 'Select * FROM BD_Author WHERE Name like ?;';
            db.query({
                sql: query,
                values: [ ctx.params.name]
            }, (err,res) => {
                if(err) {
                    reject(err);
                }
                ctx.body = res;
                resolve();
            });
        });
    }
    // Method to get the total awards of each authors
    static getTotalAwards(ctx){
        return new Promise((resolve,reject) =>{
            const query = 'SELECT * FROM total_Awards;';
            db.query(query, (err,res) => {
                if(err) {
                    reject(err);
                }
                ctx.body = res;
                resolve();
            });
        });
    }
    // Method to get the average review of authors
    static getAverageReview(ctx){
        return new Promise((resolve,reject) =>{
            const query = 'SELECT * FROM average_review;';
            db.query(query, (err,res) => {
                if(err) {
                    reject(err);
                }
                ctx.body = res;
                resolve();
            });
        });
    }
    // Method to get the best reviewed book of an author
    static getbestReview(ctx){
        return new Promise((resolve,reject) =>{
            const query = 'Select fn_GetBestReviewed(?) AS ?;';
            db.query({
                sql: query,
                values: [ctx.params.name, ctx.params.name]
            }, (err,res) => {
                if(err) {
                    reject(err);
                }
                ctx.body = res;
                resolve();
            });
        });
    }
    // Method to close the database connection
    static close() {
        db.end();
    }
}

module.exports = authorController;