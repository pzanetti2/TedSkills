import 'package:flutter/material.dart';
import '../models/talk.dart';
import '../repositories/talk_repository.dart';
import '../widgets/shared_widgets.dart';

class GetByTagScreen extends StatefulWidget {
  const GetByTagScreen({super.key});

  @override
  State<GetByTagScreen> createState() => _GetByTagScreenState();
}

class _GetByTagScreenState extends State<GetByTagScreen> {
  final TextEditingController _controller = TextEditingController();
  late Future<List<Talk>> _talks;
  int _page = 1;
  bool _init = true; 

  @override
  void initState() {
    super.initState();
    _talks = initEmptyList();
  }

  void _search() {
    setState(() {
      _init = false;
      _page = 1;
      _talks = getTalksByTag(_controller.text, _page);
    });
  }

  void _loadMore() {
    setState(() {
      _page += 1;
      _talks = getTalksByTag(_controller.text, _page);
    });
  }

  void _resetSearch() {
    setState(() {
      _init = true;
      _page = 1;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'TedSkills',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
            letterSpacing: -0.3,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
          onPressed: _init ? () => Navigator.pop(context) : _resetSearch,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _init ? _buildSearchForm() : _buildResults(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: !_init
          ? FloatingActionButton(
              onPressed: _loadMore,
              child: const Icon(Icons.arrow_drop_down),
            )
          : null,
    );
  }

  Widget _buildSearchForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Inserisci il tag da cercare',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.tag_rounded, color: Color(0xFF2563EB)),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _search,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text('Cerca per tag', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }

  Widget _buildResults() {
    return FutureBuilder<List<Talk>>(
      future: _talks,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final talks = snapshot.data!;
          return Column(
            children: [
              Text(
                '#${_controller.text}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: talks.length,
                  itemBuilder: (context, index) {
                    final talk = talks[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: index % 2 == 0 ? Colors.white : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(talk.title,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          talk.details,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(talk.details)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return ErrorState(
            message: snapshot.error.toString(),
            onRetry: _search,
          );
        }
        return const Center(child: CircularProgressIndicator(color: Color(0xFF2563EB)));
      },
    );
  }
}