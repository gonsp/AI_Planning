(define (problem simple_problem)
  (:domain redflix_domain)
  (:objects
    c1 c2 c3 c4 c5 - content
  )

  (:init
    (to_watch c5)
    (watched c1 never)
    (watched c2 never)
    (watched c3 never)
    (watched c4 never)
    (watched c5 never)
    (= (contents_today) 0)
    (= (minutes_today) 0)
    (= (totals_watched) 0)
    (= (duration c1) 45) 
  )

  (:metric
    minimize (totals_watched)
  )

  (:goal
    ;;(forall (?x - content)
    ;;    (or (not (to_watch ?x)) (watched ?x somewhen))
    ;;)
        (watched c1 somewhen)
  )
)