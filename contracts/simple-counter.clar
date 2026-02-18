;; simple-counter-extended.clar
;; Clean, error-free extended Clarity contract with more functions

(define-data-var counter int 0)

(define-constant ERR_UNDERFLOW u100)
(define-constant ERR_NEGATIVE u200)
(define-constant ERR_TOO_LARGE u300)

;; ---------------------------------------------------
;; BASIC FUNCTIONS
;; ---------------------------------------------------

(define-public (increment)
  (begin
    (var-set counter (+ (var-get counter) 1))
    (ok (var-get counter))
  )
)

(define-public (increment-by (amount int))
  (if (>= amount 0)
      (begin
        (var-set counter (+ (var-get counter) amount))
        (ok (var-get counter))
      )
      (err ERR_NEGATIVE)
  )
)

(define-public (decrement)
  (if (>= (var-get counter) 1)
      (begin
        (var-set counter (- (var-get counter) 1))
        (ok (var-get counter))
      )
      (err ERR_UNDERFLOW)
  )
)

(define-public (decrement-by (amount int))
  (if (and (>= amount 0) (>= (var-get counter) amount))
      (begin
        (var-set counter (- (var-get counter) amount))
        (ok (var-get counter))
      )
      (err ERR_UNDERFLOW)
  )
)

(define-public (reset (new-value int))
  (if (>= new-value 0)
      (begin
        (var-set counter new-value)
        (ok (var-get counter))
      )
      (err ERR_NEGATIVE)
  )
)

(define-public (clear)
  (begin
    (var-set counter 0)
    (ok 0)
  )
)

;; ---------------------------------------------------
;; ADDITIONAL LOGIC FUNCTIONS
;; ---------------------------------------------------

;; Only update if new-value is greater
(define-public (set-if-greater (new-value int))
  (if (> new-value (var-get counter))
      (begin
        (var-set counter new-value)
        (ok (var-get counter))
      )
      (ok (var-get counter))
  )
)

;; Multiply counter by a given positive integer
(define-public (multiply-by (factor int))
  (if (>= factor 0)
      (begin
        (var-set counter (* (var-get counter) factor))
        (ok (var-get counter))
      )
      (err ERR_NEGATIVE)
  )
)

;; Divide counter safely, return err if divisor is zero
(define-public (divide-by (divisor int))
  (if (not (is-eq divisor 0))
      (begin
        (var-set counter (/ (var-get counter) divisor))
        (ok (var-get counter))
      )
      (err ERR_NEGATIVE)
  )
)

;; Set max limit - prevents counter from exceeding value
(define-public (set-max (max-value int))
  (if (> (var-get counter) max-value)
      (err ERR_TOO_LARGE)
      (ok true)
  )
)

;; Returns true if counter is even
(define-read-only (is-even)
  (ok (is-eq (mod (var-get counter) 2) 0))
)

;; Returns true if counter is odd
(define-read-only (is-odd)
  (ok (is-eq (mod (var-get counter) 2) 1))
)

;; ---------------------------------------------------
;; READ-ONLY GETTERS
;; ---------------------------------------------------

(define-read-only (get-counter)
  (ok (var-get counter))
)

(define-read-only (get-double)
  (ok (* 2 (var-get counter)))
)

(define-read-only (get-square)
  (ok (* (var-get counter) (var-get counter)))
)
