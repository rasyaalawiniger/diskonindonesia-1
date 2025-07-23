import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:typed_data';

final supabaseServiceProvider = Provider<SupabaseService>((ref) {
  return SupabaseService();
});

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  SupabaseClient get client => _client;

  // Generic CRUD operations
  Future<List<Map<String, dynamic>>> select(
    String table, {
    String? select,
    Map<String, dynamic>? filters,
    String? orderBy,
    bool ascending = true,
    int? limit,
  }) async {
    try {
      PostgrestFilterBuilder query = _client.from(table).select(select ?? '*');
      
      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value) as PostgrestFilterBuilder;
        });
      }
      
      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending) as PostgrestFilterBuilder;
      }
      
      if (limit != null) {
        query = query.limit(limit) as PostgrestFilterBuilder;
      }
      
      final response = await query;
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Failed to fetch data from $table: $e');
    }
  }

  Future<Map<String, dynamic>?> selectSingle(
    String table, {
    String? select,
    required Map<String, dynamic> filters,
  }) async {
    try {
      PostgrestFilterBuilder query = _client.from(table).select(select ?? '*');
      
      filters.forEach((key, value) {
        query = query.eq(key, value) as PostgrestFilterBuilder;
      });
      
      final response = await query.single();
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _client
          .from(table)
          .insert(data)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to insert data into $table: $e');
    }
  }

  Future<Map<String, dynamic>> update(
    String table,
    Map<String, dynamic> data,
    Map<String, dynamic> filters,
  ) async {
    try {
      PostgrestFilterBuilder query = _client.from(table).update(data);
      
      filters.forEach((key, value) {
        query = query.eq(key, value) as PostgrestFilterBuilder;
      });
      
      final response = await query.select().single();
      return response;
    } catch (e) {
      throw Exception('Failed to update data in $table: $e');
    }
  }

  Future<void> delete(
    String table,
    Map<String, dynamic> filters,
  ) async {
    try {
      PostgrestFilterBuilder query = _client.from(table).delete();
      
      filters.forEach((key, value) {
        query = query.eq(key, value) as PostgrestFilterBuilder;
      });
      
      await query;
    } catch (e) {
      throw Exception('Failed to delete data from $table: $e');
    }
  }

  // Real-time subscriptions
  RealtimeChannel subscribe(
    String table,
    void Function(PostgresChangePayload) callback, {
    PostgresChangeEvent? event,
    Map<String, dynamic>? filters,
  }) {
    var channel = _client.channel('public:$table');
    
    var subscription = channel.onPostgresChanges(
      event: event ?? PostgresChangeEvent.all,
      schema: 'public',
      table: table,
      callback: callback,
    );
    
    channel.subscribe();
    return channel;
  }

  void unsubscribe(RealtimeChannel channel) {
    channel.unsubscribe();
  }

  // File storage operations
  Future<String> uploadFile(
    String bucket,
    String path,
    Uint8List fileBytes, {
    Map<String, String>? metadata,
  }) async {
    try {
      await _client.storage.from(bucket).uploadBinary(
        path,
        fileBytes,
        fileOptions: FileOptions(
          upsert: true,
          metadata: metadata,
        ),
      );
      
      return _client.storage.from(bucket).getPublicUrl(path);
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }

  Future<void> deleteFile(String bucket, String path) async {
    try {
      await _client.storage.from(bucket).remove([path]);
    } catch (e) {
      throw Exception('Failed to delete file: $e');
    }
  }

  String getPublicUrl(String bucket, String path) {
    return _client.storage.from(bucket).getPublicUrl(path);
  }

  // Edge Functions
  Future<Map<String, dynamic>> invokeFunction(
    String functionName,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _client.functions.invoke(
        functionName,
        body: body,
      );
      
      return response.data;
    } catch (e) {
      throw Exception('Failed to invoke function $functionName: $e');
    }
  }

  // Transaction operations
  Future<T> transaction<T>(Future<T> Function() operation) async {
    // Note: Supabase doesn't have explicit transaction support in Dart client
    // This is a placeholder for future implementation or custom logic
    return await operation();
  }

  // Batch operations
  Future<List<Map<String, dynamic>>> batchInsert(
    String table,
    List<Map<String, dynamic>> data,
  ) async {
    try {
      final response = await _client
          .from(table)
          .insert(data)
          .select();
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Failed to batch insert data into $table: $e');
    }
  }

  // Custom queries with RPC
  Future<dynamic> rpc(
    String functionName, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _client.rpc(functionName, params: params);
      return response;
    } catch (e) {
      throw Exception('Failed to execute RPC $functionName: $e');
    }
  }

  // Health check
  Future<bool> isHealthy() async {
    try {
      await _client.from('users').select('user_id').limit(1);
      return true;
    } catch (e) {
      return false;
    }
  }
}