File documentation can be found in /doc/table_of_contents.html

# Instructions

1. Install Bundler using ```gem install bundler```
2. Go to the scripts root directory and run ```bundle install```
3. Run the script using ```ruby spread_challenge.rb <location/to/bond/data>.csv```

Both ```spread_to_benchmark``` and ```spread_to_curve``` data will be exported to individually CSV files in the projects root directory.

# Reasoning

There are several main components to this solution.

1. Bond
2. BondCollection
3. SpreadCalculator
4. LinearInterpolator
5. Formatter

The script starts by importing the CSV file and running all the rows through the Formatter so that calculations can be done on the proper data type.

The Bond and BondCollection class is used to provide an immutable enumerable collection of bonds that simplifies finding benchmark candidates for calculating spread. The immutability simplifies using slightly modified variations of a collection to calculate spread without having to worry about managing collisions. If you wanted to take this further, the immutability would allow this process to be threaded safety to improve performance.

Finding potential benchmark candidates is done by adding a corporate bond to a collection of government bonds sorted by term. This makes it trivially easy to find candidates to use to calculate spread which is done using the SpreadCalculator.

The calculation used by the SpreadCalculator is performed in LinearInterpolator but this could be swapped out for any other type of calculation that would be appropriate.

Once all the calculations are performed for both spread types, the Formatter is used one last time to prettify the output that will be written to the CSV files.


# Tradeoffs

This implementation is very specific to calculating everything in memory. In a client/server environment, using indexes and querying data would be more appropriate depending on the size of the dataset, how much memory is available on the server, and how many spread calculations need to be performed at once. If the dataset in this example was extremely large, an immutable data structure could raise could cause some issues.

If I had more time and more details about different edge cases for calculations, I'd right a more robust testing suite. Having a strong integration tests for SpreadCalculator would help cover most of the script. Also, the Formatter class is very specific to the requirements of this challenge. It could probably be refactored to be a bit more extensible.

