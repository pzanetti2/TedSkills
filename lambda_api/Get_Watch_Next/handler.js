const connect_to_db = require('./db');
const talk = require('./Talk');

module.exports.get_watch_next = async (event, context, callback) => {
    context.callbackWaitsForEmptyEventLoop = false;
    
    let body = {};
    if (event.body) {
        body = JSON.parse(event.body);
    }

    const id = body.id || body.idx; 

    if (!id) {
        return callback(null, {
            statusCode: 400,
            headers: { 'Content-Type': 'text/plain' },
            body: 'Id missing'
        });
    }

    try {
        await connect_to_db();
        
        const video = await talk.findOne({ _id: String(id) });

        if (!video) {
            return callback(null, {
                statusCode: 404,
                headers: { 'Content-Type': 'text/plain' },
                body: 'No video in the database'
            });
        }

        const original_skill = video.soft_skill || 'Competenza trasversale generica';
        const watch_next_ids = video.watch_next || [];

        const recommended = await talk.find({ _id: { $in: watch_next_ids }});

        let recommendations = recommended.map(doc => {
            return {
                 id: doc._id,
                title: doc.title,
                url: doc.url,
                soft_skill: doc.soft_skill || 'Competenza trasversale generica'
            };
        });

        // Sort for softskill
        recommendations.sort((a, b) => {
            const first = (a.soft_skill === original_skill);
            const second = (b.soft_skill === original_skill);

            if (first && !second) {
                return -1; 
            } else if (!first && second) {
                return 1;  
            }
            return 0;
        });

        return callback(null, {
            statusCode: 200,
            headers: { 
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            body: JSON.stringify({
                original_video_id: id,
                original_title: video.title,
                soft_skill_in_focus: original_skill,
                recommended_videos: recommendations
            })
        });

    } catch (err) {
        console.error('Search error:', err);
        return callback(null, {
            statusCode: 500,
            headers: { 'Content-Type': 'text/plain' },
            body: 'Internal Server Error'
        });
    }
};