/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
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
        CASE
            WHEN data->'extended_tweet'->'entities'->'hashtags' IS NOT NULL
            THEN data->'extended_tweet'->'entities'->'hashtags'
            ELSE COALESCE(data->'entities'->'hashtags','[]')
        END
    ) AS ht
    WHERE data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
       OR data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
) t
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;
