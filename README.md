# Welcome To The Jungle technical test

## Getting Started

Simply run `mix deps.get` to fetch required dependencies then `iex -S mix` to access elixir interactive shell with the project loaded up.

Two CSV files are present in the `./data` folder needed to aggregate jobs data.


## Ideas behind my implementation

### Continents

In order to determine continents from longitude and latitude positions, my first idea was to create a bounding box
for each continents and then calculate if the point was inside or outside this box. I would have had only 6 boxes with 2 points each (minX,Y and maxX,Y or bottom-left and top-right). A pretty quick solution I think.

![asia in bounding box](https://i.imgur.com/aWuRgD5.png "http://bboxfinder.com") 

But I encountered a first problem with Asia and its not so squared borders. So I designed multiple boxes for each complicated continents but I wasn't quite happy with this solution because I think I would have lost some clarity. So instead I went with 1 continent, 1 polygon. (I think it would be interesting to run few benchmarks with both solutions to determine if performances were really impacted or not so much)

## Built With

* [Elixir 1.10.1](https://github.com/elixir-lang/elixir/releases/tag/v1.10.1)

## Author

* **Clément Quaresma**