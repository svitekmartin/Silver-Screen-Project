select coalesce(genre, 'Unknown') as genre_cleaned
from silverscreen.public.movie_catalogue
