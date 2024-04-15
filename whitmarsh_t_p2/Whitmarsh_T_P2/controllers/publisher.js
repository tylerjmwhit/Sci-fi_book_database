const db = require('../database/connection');

class publisherController{
    // Method to get all publishers
    static getpublishers(ctx){
        return new Promise((resolve,reject) =>{
            const query = 'Select * FROM BD_Publisher;';
            db.query(query, (err,res) => {
                if(err) {
                    reject(err);
                }
                ctx.body = res;
                resolve();
            });
        });
    }
    // Method to get phone numbers of a specific publisher
    static getPhonenumbers(ctx){
        return new Promise((resolve,reject) =>{
            const query = 'Select * FROM BD_Publisher_PhoneNumber Where Name like ?;';
            db.query({
                sql:query,
                values:[ctx.params.name]
                }, (err,res) => {
                if(err) {
                    reject(err);
                }
                ctx.body = res;
                resolve();
            });
        });
    }
    // Method to get a publisher by name
    static getPublisherByName(ctx){
        return new Promise((resolve,reject) =>{
            const query = 'Select * FROM BD_Publisher Where Name like ?;';
            db.query({
                sql:query,
                values:[ctx.params.name]
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
module.exports = publisherController;