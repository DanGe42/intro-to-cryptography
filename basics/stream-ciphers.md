{% extends "base.md" %}

{% block article %}

# Stream ciphers

## A new definition of security

Recall that the one-time pad is perfectly secret, but only if the length of the
key is at least the length of the message. And while our previous definition
of perfect indistinguishability is a very appealing definition in theory, it is
an impossible definition to work with in practice.

For more practical cryptography, we would like our encryption scheme to have
computational indistinguishability; in this model, the adversary is
computationally-bounded and is limited to "efficient" algorithms. While this is
weaker than perfect indistinguishability, it only has a negligible difference.

## A game model

We model our computationally-bounded adversary with a game. We have two players
in this game: the adversary $A$ and the verifier $V$.

<!-- TODO: diagram of the game -->

In this game, the adversary creates two messages $m_0$ and $m_1$ to the
verifier. The verifier, in probabilistic polynomial time, generates a key of
length $n$ and also randomly selects a message to encrypt. The message that is
encrypted is $m_b$, where $b \in_R \{0, 1\}$, and the ciphertext is sent back
to the adversary. The adversary, in probabilistic polynomial time, chooses a
$b'$ and sends it back to the verifier; if $b' = b$, then the adversary wins.

In short, the adversary wins if it knows which message was selected by the
verifier to be encrypted.

## Computational indistinguishability

A cryptosystem $(Gen, Enc, Dec)$ is indistinguishable if:

$$ Pr[\text{A succeeds}] \leq \frac{1}{2} + \epsilon(n) $$

where

$$ \epsilon(n) < \frac{1}{p(n)} \forall \text{polynomial } p(\cdot) $$

<!-- TODO: WTF does that mean ^^ -->

In other words, adversary $A$ is allowed to use randomized algorithms in
polynomial time.

## Semantic security

{% endblock %}
