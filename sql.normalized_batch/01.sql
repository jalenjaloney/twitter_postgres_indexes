/*
 * Count the number of tweets that use #coronavirus
 */

/*
SELECT count(distinct id_tweets)
FROM tweet_tags
WHERE tag='#coronavirus';
*/

SELECT count(distinct data->>'id')
FROM tweets_jsonb
WHERE data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]' OR data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]';

-- @> = "contains"

CREATE INDEX ON tweets_jsonb
