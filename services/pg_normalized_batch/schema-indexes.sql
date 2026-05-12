SET max_parallel_maintenance_workers TO 80;
SET maintenance_work_mem = '16GB';

CREATE INDEX ON tweet_tags (tag);
CREATE INDEX ON tweet_tags (id_tweets, tag);
CREATE INDEX ON tweets (id_tweets);
CREATE INDEX ON tweets USING gin(to_tsvector('english',text));
