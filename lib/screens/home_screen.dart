import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/screens/add_edit_task_screen.dart';
import 'package:task_manager/services/auth_service.dart';
import 'package:task_manager/services/quote_service.dart';
import 'package:task_manager/services/task_provider.dart';
import 'package:task_manager/widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authService = AuthService();
  final _quoteService = QuoteService();
  Map<String, String> _quote = {'quote': '', 'author': ''};
  bool _quoteLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuote();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Future.microtask(
        () => context.read<TaskProvider>().listenToTasks(user.uid),
      );
    }
  }

  Future<void> _loadQuote() async {
    try {
      final quote = await _quoteService.getRandomQuote();
      setState(() {
        _quote = quote;
        _quoteLoading = false;
      });
    } catch (e) {
      setState(() {
        _quote = {'quote': 'Stay focused and keep going!', 'author': 'Unknown'};
        _quoteLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.logout();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Quote Card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.deepPurple[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _quoteLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          Text(
                            '"${_quote['quote']}"',
                            style: const TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '- ${_quote['author']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          // Task List
          Expanded(
            child: taskProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : taskProvider.tasks.isEmpty
                ? const Center(
                    child: Text(
                      'No tasks yet!\nTap + to add one.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (context, index) {
                      final task = taskProvider.tasks[index];
                      return TaskCard(
                        task: task,
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEditTaskScreen(task: task),
                            ),
                          );
                        },
                        onDelete: () async {
                          await taskProvider.deleteTask(task.id);
                        },
                        onToggleComplete: () async {
                          await taskProvider.toggleComplete(task);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
