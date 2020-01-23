a = '<body>
<div id="header">
  <div class="login">
      <a href="/movies/login">Login</a>
  </div>
  <h1>Netslip: The Best Alternative for DVD Rentals</h1>
</div>
<h1>Available Movies</h1>
<p>Here are the movies that match your selection criteria. Click
any title to rent that movie.</p>
<table cellspacing="0" class="oddEven">
<tr class="header">
<td>Title</td>
<td>Director</td>
<td>Star</td>
<td>Year of Release</td>
<td>Genre</td>
<td>Rating</td>
</tr>
  <tr class="even">
    <td><a href="/movies/rent?id=830">Anne McCabe</a></td>
    <td>0419372296000513</td>
    <td>10</td>
    <td>2010</td>
    <td>923</td>
    <td>E. Lansing</td>
  </tr>
  <tr class="odd">
    <td><a href="/movies/rent?id=882">Brock Rifleshot</a></td>
    <td>7724815006319242</td>
    <td>6</td>
    <td>2013</td>
    <td>186</td>
    <td>Pflugerville</td>
  </tr>
  <tr class="even">
    <td><a href="/movies/rent?id=87">Juan Salvador</a></td>
    <td>2701869244389816</td>
    <td>3</td>
    <td>2011</td>
    <td>714</td>
    <td>New York</td>
  </tr>
  <tr class="odd">
    <td><a href="/movies/rent?id=18862">LaRegis Williams</a></td>
    <td>3980112415634271</td>
    <td>9</td>
    <td>2011</td>
    <td>155</td>
    <td>Wichita</td>
  </tr>
  <tr class="even">
    <td><a href="/movies/rent?id=66">Lily Hamtread</a></td>
    <td>4141635972064003</td>
    <td>8</td>
    <td>2011</td>
    <td>849</td>
    <td>Denver</td>
  </tr>
  <tr class="odd">
    <td><a href="/movies/rent?id=316">Nguyen Tranh</a></td>
    <td>3617552384199132</td>
    <td>1</td>
    <td>2012</td>
    <td>404</td>
    <td>Kissimmee</td>
  </tr>
  <tr class="even">
    <td><a href="/movies/rent?id=1605">Parker Blackberry</a></td>
    <td>2367501900420036</td>
    <td>6</td>
    <td>2010</td>
    <td>992</td>
    <td>Anchorage</td>
  </tr>
  <tr class="odd">
    <td><a href="/movies/rent?id=18">Sharon LaLonde</a></td>
    <td>0621054337998620</td>
    <td>3</td>
    <td>2011</td>
    <td>576</td>
    <td>Haysville</td>
  </tr>
  <tr>
    <td><a href="/movies/rent?id=1089">Wei-Ling Cheng</a></td>
    <td>2036419487598423</td>
    <td>10</td>
    <td>2010</td>
    <td>148</td>
    <td>Muncie</td>
  </tr>
  <tr>
    <td><a href="/movies/rent?id=476">William McJones</a></td>
    <td>6140991237458010</td>
    <td>12</td>
    <td>2012</td>
    <td>135</td>
    <td>Glenside</td>
  </tr>
</table>

</body>'
b = a.scan(/<td>(.*)<\/td>/)
puts "running"
b.each do |c|
    puts  c 
end
