USE pubs;

/* Challenge 1 - Who Have Published What At Where? */

SELECT
	a.au_id AS 'AUTHOR ID', 
	a.au_lname AS 'LAST NAME',
    a.au_fname AS 'FIRST NAME',
	t.title AS 'TITLE',
	p.pub_name AS 'PUBLISHER'
FROM pubs.authors AS a
JOIN pubs.titleauthor AS ta
	ON a.au_id = ta.au_id
JOIN pubs.titles as t
	ON ta.title_id = t.title_id
JOIN pubs.publishers as p
	ON t.pub_id = p.pub_id
ORDER BY 
    a.au_id,
    t.title;

/*Challenge 2 - Who Have Published How Many At Where?*/
SELECT
	a.au_id AS 'AUTHOR ID', 
	a.au_lname AS 'LAST NAME',
    a.au_fname AS 'FIRST NAME',
	p.pub_name AS 'PUBLISHER',
    COUNT(t.title_id) AS 'TITLE COUNT'
FROM pubs.authors AS a
JOIN pubs.titleauthor AS ta
	ON a.au_id = ta.au_id
JOIN pubs.titles as t
	ON ta.title_id = t.title_id
JOIN pubs.publishers as p
	ON t.pub_id = p.pub_id
GROUP BY 
    a.au_id,
    a.au_lname,
    a.au_fname,
    p.pub_name
ORDER BY COUNT(t.title_id) DESC;

SELECT COUNT(*)
FROM pubs.titleauthor;

/* Challenge 3 - Best Selling Authors */
SELECT
	a.au_id AS 'AUTHOR ID', 
	a.au_lname AS 'LAST NAME',
    a.au_fname AS 'FIRST NAME',
	SUM(s.qty) AS 'TOTAL'
FROM pubs.authors AS a
JOIN pubs.titleauthor AS ta 
	ON a.au_id = ta.au_id
JOIN pubs.titles AS t
	ON ta.title_id = t.title_id
JOIN pubs.sales AS s
	ON t.title_id = s.title_id
GROUP BY 
	a.au_id, 
	a.au_lname,
    a.au_fname,
    s.qty
ORDER BY SUM(s.qty) DESC
LIMIT 3;

/* Challenge 4 - Best Selling Authors Ranking */
SELECT
	a.au_id AS 'AUTHOR ID', 
	a.au_lname AS 'LAST NAME',
    a.au_fname AS 'FIRST NAME',
	SUM(s.qty) AS 'TOTAL'
FROM pubs.authors AS a
LEFT JOIN pubs.titleauthor AS ta 
	ON a.au_id = ta.au_id
LEFT JOIN pubs.titles AS t
	ON ta.title_id = t.title_id
LEFT JOIN pubs.sales AS s
	ON t.title_id = s.title_id
GROUP BY 
	a.au_id, 
	a.au_lname,
    a.au_fname
ORDER BY TOTAL DESC;
