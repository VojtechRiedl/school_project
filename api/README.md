
# Endpointy


## API Reference

### LOGIN

#### register user

```http
  POST /register/
```
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### login user

```http
  POST /login/
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

### USER

#### update user information

```http
  PATCH /user/update/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `id`      | `string` | **Required**. Id of user to update |

### SONGS

#### get all songs

```http
  GET /songs/
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### get song

```http
  GET /songs/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `id`      | `string` | **Required**. Id of song to fetch |

#### add song

```http
  POST /songs/add
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### remove song

```http
  DELETE /songs/delete/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `id`      | `string` | **Required**. Id of song to delete |

#### update song

```http
  PATCH /songs/update/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `id`      | `string` | **Required**. Id of song to update |


### ideas

#### get ideas

```http
  GET /ideas/
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### get idea

```http
  GET /ideas/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `id`      | `string` | **Required**. Id of idea to get |

#### update idea

```http
  PATCH /ideas/update/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `id`      | `string` | **Required**. Id of idea to update |

#### update idea

```http
  DELETE /ideas/remove/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `id`      | `string` | **Required**. Id of idea to remove |

#### add idea

```http
  POST /ideas/add
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |

### plans

#### get plans

```http
  GET /plans/
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### get plan

```http
  GET /plans/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `id`      | `string` | **Required**. Id of plan to get |

#### update plan

```http
  PATCH /plans/update/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `id`      | `string` | **Required**. Id of plan to update |

#### update plan

```http
  DELETE /plans/remove/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `id`      | `string` | **Required**. Id of plan to remove |

#### add plan

```http
  POST /plans/add
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |

### plans

#### get plans

```http
  GET /plans/
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### get plan

```http
  GET /plans/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `id`      | `string` | **Required**. Id of plan to get |

#### update plan

```http
  PATCH /plans/update/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `id`      | `string` | **Required**. Id of plan to update |

#### update plan

```http
  DELETE /plans/remove/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `id`      | `string` | **Required**. Id of plan to remove |

#### add plan

```http
  POST /plans/add
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key |















