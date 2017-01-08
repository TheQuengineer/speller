# Speller

Speller is an automated system that is responsible for spelling any word
or phrase given. This goes with the the Blog post on Automating the Future
called `Automated Problem Solving with Genetic Algorithms`. This algorithm has
not been parallelized as of yet, so larger words or phrases will take a considerable
amount of time to complete. The purpose of the project was to illustrate a
easy to grasp example of Genetic algorithms. Feel free to download this code
and play around and tweak it as you see fit. It is available to help users get
the main concept behind genetic programs. For more information visit
[Genetic Programming site](http://geneticprogramming.com/software/)
[Automating The Future](http://www.automatingthefuture.com)

# Example

```bash
#Start the system
~/source/speller (master)  ⅀  λ iex -S mix


# Tell Speller to spell a word
iex(1)> Speller.spell "Hi"
WORKING TOWARD GOAL: Hi
====================================
RESULT                       FITNESS

Hb                             1
Hi                             2
TARGET REACHED!!!!
Hi                             2
```

If you have a fast machine it should solve rather quickly, however, bigger words
or phrases doesn't have a really good performance because the code has not been
parallelized as of yet. That will perhaps be the next version of this project.
For now, I believe it illustrates the point of the post quite well.
