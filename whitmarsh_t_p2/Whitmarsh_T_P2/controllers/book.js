const db = require('../database/connection');

class bookController{
    // Method to get all books
    static getBooks(ctx){
        return new Promise((resolve,reject) =>{
            const query = 'Select * FROM BD_Book;';
            db.query(query, (err,res) => {
                if(err) {
                    reject(err);
                }
                ctx.body = res;
                resolve();
            });
        });
    }
    // Method to get books by title and author
    static getBooksByKey(ctx){
        return new Promise((resolve,reject) =>{
            const query = 'Select * FROM BD_Book WHERE Title like ? and Author_Name like ?;';
            db.query({
                sql: query,
                values: [ ctx.params.title, ctx.params.author]
            }, (err,res) => {
                if(err) {
                    reject(err);
                }
                ctx.body = res; 
                resolve();
            });
        });
    }
    // Method to get the best reviewed books
    static getBestReviewed(ctx){
        return new Promise((resolve,reject) =>{
            const query = 'select * from top_rating;';
            db.query(query, (err,res) => {
                if(err) {
                    reject(err);
                }
                ctx.body = res;
                resolve();
            });
        });


    }
    // Method to get the average review of books
    static getAverageReview(ctx){
        return new Promise((resolve,reject) =>{
            const query = 'select * from ratings_View;';
            db.query(query, (err,res) => {
                if(err) {
                    reject(err);
                }
                ctx.body = res;
                resolve();
            });
        });


    }
    // Method to add a new book
    static addBook(ctx){
        return new Promise((resolve,reject) => {
            const book = ctx.request.body;
            const query = `
            INSERT INTO BD_Book (Title, Author_Name, Genre, Publisher_Name)
            VALUES (?,?,?,?);
            `;

            db.query({
                sql: query,
                values: [book.Title, book.author_name, book.genre, book.publisher_name]
            }, (err, res) => {
                if(err) {
                    reject(err);
                }
                ctx.status = 201;
                resolve();
            });
        });
    }
    // Method to update a book by title and author
    static updateBookByKey(ctx){
        return new Promise((resolve, reject) => {
            const book = ctx.request.body;
            const query = `
                UPDATE BD_Book
                SET Genre = ?,
                Publisher_Name = ?
                WHERE Title like ? AND
                Author_Name like ?;
            `;
            db.query({
                sql: query,
                values: [book.genre, book.publisher_name, ctx.params.title, ctx.params.author]
            }, (err, res)=>{
                if(err) {
                    reject(err);
                }
                ctx.status = 200;
                resolve()
            });
        })
    }
    // Method to delete a book by title and author
    static deleteBookByKey(ctx){
        return new Promise((resolve, reject) => {
            const query = 'DELETE FROM BD_Book WHERE Title like ? and Author_Name like ?;'; 
            db.query({
                sql: query,
                values: [ ctx.params.title, ctx.params.author]
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
module.exports = bookController;