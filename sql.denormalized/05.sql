/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */

SELECT
    concat('#', tag_text) AS tag,
    count(*) AS count
FROM (
    SELECT DISTINCT
        data->>'id' AS id_tweets,
        ht->>'text' AS tag_text
    FROM tweets_jsonb,
    jsonb_array_elements(
        COALESCE(data->'entities'->'hashtags','[]') ||
        COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')
    ) AS ht
    WHERE to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')) @@ to_tsquery('english', 'coronavirus')
      AND data->>'lang' = 'en'
) t
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;
