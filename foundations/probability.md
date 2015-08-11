{% extends "base.md" %}

{% block article %}

# Probability

Probability serves as an important foundation of the study of cryptography.
Here, we will review a few fundamental concepts in probability.

<!-- TODO finish this entire page -->

## Probability

<!-- TODO: A lot of this might not be explained very well. Teaching probability
  is hard. -->

**Probability** represents the likelihood that a certain event occurs. More
formally, it is a function that maps a sample space to a set of outcomes.

### Sample spaces

Our notation will be as follows:

* $\omega$: An event
* $\Omega$: A sample space
* $Pr(\omega)$: The probability that event $\omega$ occurs. Note that the
  constraint $0 \leq Pr(\omega) \leq 1$ must be satisfied.

As an example, let's look at a simple toss of a fair coin. The sample space is
$\Omega = \{H, T\}$ (where $H$ is heads and $T$ is tails). It holds that
$Pr(H) = Pr(T) = \frac{1}[2}$. To extend on this, if we toss two fair coins,
our sample space becomes $\Omega = \{HH, HT, TH, TT\}$.

The sum of all probabilities over a sample space must add up to 1. In other
words, $\sum_{\omega \in \Omega} Pr(\omega) = 1$.

If $A \subseteq \Omega$, then the set of events $A$ is considered a **sample
subset** of sample space $\Omega$. It follows that
$Pr(A) = \sum_{\omega \in A} Pr(\omega)$. For example, consider a six-sided
dice roll. Its sample space is $\Omega = \{1..6\}$. Let $A$ be the subset of
odd numbers in $\Omega$ (i.e. $A = \{1, 3, 5\}$). It follows that
$Pr(A) = \sum_{\omega \in \{1, 3, 5\}} Pr(\omega) = \frac{1}{2}$.

### Conjunctions and disjunctions

A **disjunction** is defined as $Pr(A \wedge B)$. This represents the
probability that both an event from $A$ and an event from $B$ occur.

A **conjunction** of probability spaces is defined as $Pr(A \vee B) = Pr(A)
+ Pr(B) - Pr(A \wedge B)$. This represents the probability that either an event
from $A$ or an event $B$ occurs (or both). We subtract off the $Pr(A \wedge B)$
to avoid double-counting. It holds that $Pr(A \vee B) \leq Pr(A) + Pr(B)$,
where $Pr(A) + Pr(B)$ is called the "union bound".

Events $A$ and $B$ are **independent** if and only if $Pr(A \wedge B) = Pr(A)
\cdot Pr(B)$.

### Conditional probability

The probability of an event $A$ occurring, given that event $B$ occurs, is
written as $Pr(A \given B)$. It is defined as $\frac{Pr(A \wedge B)}{Pr(B)}$.

Bayes Theorem holds that:

$$Pr(A \given B) = \frac{Pr(A) \cdot Pr(B \given A)}{Pr(B)}$$

### Binomial distribution

The [binomial distribution](http://en.wikipedia.org/wiki/Binomial_distribution)
is a probability distribution of a number of independent binary (yes/no)
experiments. Given a random variable $X$ and the probability the event $k$
being $Pr(k) = p$, the binomial distribution is defined:

$$ Pr(X = k) = \binom{n}{k} p^k (1 - p)^{n-k} $$

## Expectations

## Entropy

### Jensen's Inequality

## Statistical distance

## Algorithmic distinguisher

{% endblock %}
