const connect_to_db = require('./db');
const talk = require('./Talk');

module.exports.get_gap_filler = async (event, context, callback) => {
    context.callbackWaitsForEmptyEventLoop = false;
    
    let body = {};
    if (event.body) {
        body = JSON.parse(event.body);
    }

    const student_portfolio = body.portfolio || {};

    if (Object.keys(student_portfolio).length === 0) {
        return callback(null, {
            statusCode: 400,
            headers: { 'Content-Type': 'text/plain' },
            body: 'Missing portfolio data'
        });
    }

    try {
        //Find the weakest skill for the student
        let weakest_skill = Object.keys(student_portfolio).reduce((a, b) => 
            student_portfolio[a] < student_portfolio[b] ? a : b
        );

        await connect_to_db();
        
        const recommended_talks = await talk.find({ soft_skill: weakest_skill }).limit(3);

        return callback(null, {
            statusCode: 200,
            headers: { 
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            body: JSON.stringify({
                identified_gap: weakest_skill,
                message: `Abbiamo notato che hai poche ore in ${weakest_skill}. Ecco dei talk per completare il tuo percorso:`,
                talks: recommended_talks
            })
        });

    } catch (err) {
        return callback(null, {
            statusCode: 500,
            headers: { 'Content-Type': 'text/plain' },
            body: 'Internal Error'
        });
    }
};