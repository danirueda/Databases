/*Personas*/
/*SELECT *
FROM name;*/

/*Información de las personas*/
SELECT *
FROM person_info;

/*Obtiene información de los expectáculos excluyendo la información extra en el caso de que sean episodios de serie*/
/*SELECT id,title,kind_id,production_year,series_years
FROM title;*/


/*Muestra la información extra de los episodios*/
/*SELECT id,episode_of_id,season_nr,episode_nr
FROM title
WHERE kind_id=7;*/

/* Peliculas y relación con otras */
/*SELECT * 
FROM movie_link;*/

/* Palabras clave de peliculas */
/*SELECT * 
FROM keyword;*/

/*Tabla que se crea a partir de una relación N a M entre palabras clave y películas*/
/*SELECT *
FROM movie_keyword;*/

/*SELECT P.person_id,P.movie_id,P.role_id,Q.name
FROM cast_info P,char_name Q
WHERE P.person_role_id=Q.id;*/
