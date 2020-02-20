# Welcome To The Jungle technical test

## Getting Started

Simply run `mix deps.get` to fetch required dependencies then `iex -S mix` to access elixir interactive shell with the project loaded up. The API will be available at `http://localhost:8080/`

Two CSV files are present in the `./data` folder needed to aggregate jobs data.

---

## Exercise #1

Simply run the function `aggregate_professions` in iex to fetch all professions per continents in a map: 

```
iex(1)> WttjTechnicalTest.aggregate_professions
%{
  "Africa" => %{
    "Admin" => 1,
    "Business" => 2,
    "Marketing / Comm'" => 1,
    "Retail" => 1,
    "Tech" => 3,
    "Total" => 8
  },
  "America" => %{
    "Admin" => 9,
    "Business" => 31,
    "Créa" => 7,
    "Marketing / Comm'" => 12,
    "Retail" => 93,
    "Tech" => 15,
    "Total" => 168,
    "Unknown" => 1
  } ....
}
```

## Exercice #2

## Exercice #3

The route is accessible at the endpoint `/offers` with the following query params : `latitude`, `longitude`, `radius` (in km)


```
curl -i http://localhost:8080/offers?latitude=48.8659387&longitude=2.34532&radius=1

HTTP/1.1 200 OK
cache-control: max-age=0, private, must-revalidate
content-length: 89433
content-type: application/json; charset=utf-8
date: Thu, 20 Feb 2020 15:53:53 GMT
server: Cowboy

[{"offer":"Head of Product","longitude":"2.3353917","latitude":"48.8709753","distance":917.0585203046154},{"offer":"Développeur Backend Ruby (Go/Elixir) H/F","longitude":"2.3455685","latitud
e":"48.865906","distance":18.537068784976178},{"offer":"STAGE : Startup Manager (Programme Starter)","longitude":"2.3462831","latitude":"48.8682471","distance":266.1741028910028},{"offer":"S
TAGES YOOPIES - plusieurs stages à pourvoir : Bras droit CEO, Bras droit Talent manager, Buiz Dev, Webmarketing, Product Manager, etc.","longitude":"2.3456194","latitude":"48.8740718","dista
nce":904.6257932182492},{"offer":"Stage - Account Manager Junior Associate","longitude":"2.3345591","latitude":"48.8665766","distance":790.3087665788366}, ...]

```

---

## Ideas behind my implementation

### Continents

In order to determine continents from longitude and latitude positions, my first idea was to create a bounding box
for each continents and then calculate if the point was inside or outside this box. I would have had only 6 boxes with 2 points each (minX,Y and maxX,Y or bottom-left and top-right). A pretty quick solution I think.

![asia in bounding box](https://i.imgur.com/aWuRgD5.png "http://bboxfinder.com") 

But I encountered a first problem with Asia and its not so squared borders. So I designed multiple boxes for each complicated continents but I wasn't quite happy with this solution because I think I would have lost some clarity. So instead I went with 1 continent, 1 polygon. (I think it would be interesting to run few benchmarks with both solutions to determine if performances were really impacted or not so much)

### Link professions with continents

I sorted my continents list with the idea that jobs input will be mostly European, American and Asian. Putting Antarctica first (could be removed for optimization ?) with Oceania second for example, would have been a waste of iterations to find the right continent and therefore a lost of time in average.

### Find offers in a radius

I used the great-circle distance to find the shortest distance between two points on a sphere. If this distance was inferior or equal to my radius, I would return this offer. To help me in my calculations and save me some time, I used a library to handle this.

## Built With

* [Elixir 1.10.1](https://github.com/elixir-lang/elixir/releases/tag/v1.10.1)

## Author

* **Clément Quaresma**