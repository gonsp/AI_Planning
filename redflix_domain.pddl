(define (domain redflix_domain)
  (:requirements :strips :typing :adl :equality :fluents)
  (:types content
          time)
  (:constants never somewhen before yesterday today - time)
  
  (:predicates (precedes ?x - content ?y - content)
               (parallel ?x - content ?y - content)
               (watched ?x - content ?w - time)
               (to_watch ?x - content)
               (watchedsmthtoday))
  
  (:functions (contents_today)
              (minutes_today)
              (totals_watched)
              (duration ?x - content))

  (:action watch_content
    :parameters (?x - content)
    :precondition (and (watched ?x never)
                       (forall (?y - content)
                           (and (or (not (precedes ?y ?x))
                                (or (watched ?y before)
                                   (watched ?y yesterday))
                                )
                                (or (or (not (parallel ?x ?y))
                                        (not (watched ?y somewhen)))
                                    (or (watched ?y yesterday)
                                        (watched ?y today))
                                )
                           )
                       )
                       (< (contents_today) 3)
                       (<= (+ (minutes_today) (duration ?x)) 200)
                  )
    :effect (and (watched ?x today)
                 (watched ?x somewhen)
                 (not (watched ?x never))
                 (increase (contents_today) 1)
                 (increase (minutes_today) (duration ?x))
                 (increase (totals_watched) 1)
                 (watchedsmthtoday))
  )

  (:action next_day
    :parameters ()
    :precondition (watchedsmthtoday)
    :effect (and (decrease (contents_today) (contents_today))
                 (decrease (minutes_today) (minutes_today))
                 (not (watchedsmthtoday))
                 (forall (?x - content)
                    (and (when (watched ?x yesterday) (and (not (watched ?x yesterday)) 
                                                           (watched ?x before)))
                         (when (watched ?x today) (and (not (watched ?x today))
                                                       (watched ?x yesterday)))
                    )
                 )
            )
  )
)
