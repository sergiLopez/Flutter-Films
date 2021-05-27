/*import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {


  String seleccion = '';

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            close(context, null);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final listaSugerida = ( query.isEmpty ) ? peliculasRecientes : peliculas.where( (p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: ,
      itemBuilder: (context, i){
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(peliculasRecientes[i]),
          onTap: (){
            seleccion = listaSugerida[i];
            showResults(context);
          },

        )
      },
    )
  }
}*/
