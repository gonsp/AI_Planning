(define (problem simple_problem)
  (:domain redflix_domain)
  (:objects
    c1 c2 c3 c4 c5 - content
  )

  (:init
    ;;to_watch
    (to_watch c5)
    (to_watch c3)

    ;;watched
    (watched c1 never)
    (watched c2 never)
    (watched c3 never)
    (watched c4 never)
    (watched c5 never)

    ;;precedes
    (precedes c1 c2)
    (precedes c2 c3)
    (precedes c4 c5)

    ;;parallel
    (parallel c5 c1)
    (parallel c1 c5)

    ;;duration
    (= (duration c1) 45) 
    (= (duration c2) 45) 
    (= (duration c3) 45) 
    (= (duration c4) 45) 
    (= (duration c5) 45) 
    
    ;;domain functions
    (= (contents_today) 0)
    (= (minutes_today) 0)
    (= (totals_watched) 0)
  )

  (:metric
    minimize (totals_watched)
  )

  (:goal
    (forall (?x - content)
        (or (not (to_watch ?x)) (watched ?x somewhen))
    )
  )
)
