import 'package:flutter/material.dart';
import 'package:pr5/components/item_note.dart';
import 'package:pr5/components/note_card.dart';
import 'package:pr5/models/note.dart';
import 'add_note_page.dart';
import 'favorites_notes_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Note> notes = [];
  List<Note> favorites = [];

  @override
  void initState() {
    super.initState();
    notes = [
      Note(
        id: 1,
        title: 'Dagon 5',
        description: 'Волшебная палочка, которая становится тем сильнее, чем дольше она используется. Позволяет магу срывать с кончиков пальцев волшебный заряд.',
        photo_id: 'https://liquipedia.net/commons/images/a/a0/Dagon_3_itemicon_dota2_gameasset.png',
        price: 7450,
      ),
      Note(
        id: 2,
        title: 'Assault Cuirass',
        description: 'Выкованная в кузнях преисподней, эта адская броня обеспечивает владельцу и его союзникам дополнительную броню и скорость атаки.',
        photo_id: 'https://liquipedia.net/commons/images/9/93/Assault_Cuirass_itemicon_dota2_gameasset.png',
        price: 5150,
      ),
      Note(
        id: 3,
        title: 'Bloodthorn',
        description: 'Этот ненавистный клинок топит врага в агонии, впиваясь в тело извивающейся жертвы всё сильнее и сильнее с каждым ее движением.',
        photo_id: 'https://liquipedia.net/commons/images/4/4e/Bloodthorn_itemicon_dota2_gameasset.png',
        price: 7225,
      ),
      Note(
        id: 4,
        title: 'Monkey King Bar',
        description: 'Могущественный посох, которым пользовался искусный воин.',
        photo_id: 'https://liquipedia.net/commons/images/f/f7/Monkey_King_Bar_itemicon_dota2_gameasset.png',
        price: 4900,
      ),
    ];
  }

  void _addNote(Note note) {
    setState(() {
      notes.add(note);
    });
  }

  void _openNote(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemNote(note: note, onDelete: _deleteNote),
      ),
    );
  }

  void _deleteNote(int id) {
    setState(() {
      notes.removeWhere((note) => note.id == id);
    });
  }

  void _toggleFavorite(Note note) {
    setState(() {
      if (favorites.contains(note)) {
        favorites.remove(note);
        note.isFavorite = false;
      } else {
        favorites.add(note);
        note.isFavorite = true;
      }
    });
  }

  void _removeFromFavorites(Note note) {
    setState(() {
      favorites.remove(note);
      note.isFavorite = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _getCurrentPage() {
      switch (_selectedIndex) {
        case 0:
          return _buildNoteList();
        case 1:
          return FavoritePage(
            favorites: favorites,
            onOpenNote: _openNote,
            onRemoveFromFavorites: _removeFromFavorites,
          );
        case 2:
          return ProfilePage();
        default:
          return _buildNoteList();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateNotePage(onCreate: _addNote),
                ),
              );
            },
          ),
        ],
      ),
      body: _getCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранные',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildNoteList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return NoteCard(
          note: note,
          onTap: () => _openNote(note),
          onToggleFavorite: () {
            _toggleFavorite(note);
          },
        );
      },
    );
  }
}