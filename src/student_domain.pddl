(define (domain nosliw)
  (:requirements :strips :typing)
  (:types 
	  town mountain cave - location 
	  dragon wizard hero - agent 
	  sorceress - wizard 
	  diamond sword pen - item
	  agent item location - obj
	  agent item - agentitem)
  (:predicates 	(at ?x - agentitem ?y - location) 
		(different ?x ?y - item) 
		(possesses ?x - agent ?y - item) 
		(path-from-to ?x ?y - location)
		(asleep ?x - dragon)
		(strong ?x - hero)
		(dead ?x - agent)
		(safe ?x - town))
  (:action move
		:parameters (?p - hero ?l1 ?l2 - location)
		:precondition (and (at ?p ?l1) (path-from-to ?l1 ?l2))
		:effect (and (at ?p ?l2) (not (at ?p ?l1)))  
  )

  (:action trade
		:parameters (?x ?y - agent ?a ?b - item ?l - location)
		:precondition(and (at ?x ?l) (at ?y ?l) (possesses ?x ?a) (possesses ?y ?b))
		:effect(and (possesses ?x ?b) (possesses ?y ?a))
  )  		

  (:action pick-up
		:parameters (?x - hero ?a -item ?l - location)
		:precondition(and (at ?x ?l) (at ?a ?l) (not (possesses ?x ?a)) )
		:effect(and (possesses ?x ?a) (not (at ?a ?l) ) )
  )

  (:action drop-it
		:parameters (?x - hero ?a - item ?l -location)
		:precondition(and (at ?x ?l) (not (at ?a ?l)) (possesses ?x ?a) )
		:effect (and (at ?a ?l) (not (possesses ?x ?a)) )
  )
  
  (:action lullaby
		:parameters (?x - hero ?y - dragon ?a - pen ?l - cave ?t - town)
		:precondition (and (possesses ?x ?a) 
				(at ?y ?l) 
				(not (asleep ?y))
				(not (safe ?t))
				) 
		:effect (and (asleep ?y) (safe ?t))
  )

  (:action strength-of-gods
		:parameters (?x - hero ?y - wizard ?a ?b ?c - diamond ?l - location)
		:precondition (and ( not (strong ?x)) 
				(at ?x ?l)
				(at ?y ?l)
				(different ?a ?b) (different ?b ?c) (different ?a ?c)
				(possesses ?x ?a) (possesses ?x ?b)(possesses ?x ?c))
		:effect (and (strong ?x) (possesses ?y ?a) (possesses ?y ?b) (possesses ?y ?c)) 
  )
	
  (:action final-attack
		:parameters (?x - hero ?y - dragon ?a - sword ?l - cave ?t - town)
		:precondition (and (strong ?x) (possesses ?x ?a) 
				(at ?x ?l) (at ?y ?l)
				(not (safe ?t)) 
				)
		:effect (and (dead ?y) (safe ?t)) 		

  )
)

